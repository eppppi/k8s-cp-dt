package instrumentation

import (
	"context"
	"fmt"
	"log"
	"time"

	mergelogpb "github.com/eppppi/k8s-cp-dt/mergelog/src/pkg/grpc"
	"github.com/google/uuid"
	"google.golang.org/grpc"
	"google.golang.org/grpc/credentials/insecure"
	timestamppb "google.golang.org/protobuf/types/known/timestamppb"
)

type traceContextKey string

const (
	kOC_PARENTID_KEY traceContextKey = "eppppi.github.io/koc-parentid"
	kOC_TCTX_KEY     traceContextKey = "eppppi.github.io/koc-tctx"
)

func GetParentIdFromContext(ctx context.Context) string {
	if val, ok := ctx.Value(kOC_PARENTID_KEY).(string); !ok {
		return ""
	} else {
		return val
	}

}

func SetParentIdToContext(ctx context.Context, parentId string) context.Context {
	return context.WithValue(ctx, kOC_PARENTID_KEY, parentId)
}

// GetTraceContextsFromContext returns trace contexts from ctx.
// If ctx is nil, returns nil. If there are any nil tctxs, they are ignored.
// (non-nil tctxs are returned, and len() of returned slice is the number of non-nil tctxs)
func GetTraceContextsFromContext(ctx context.Context) []*TraceContext {
	if ctx == nil {
		log.Println("EPPPPI-DEBUG: GetTraceContextsFromContext(): ctx is nil")
		return nil
	}
	if tctxs, ok := ctx.Value(kOC_TCTX_KEY).([]*TraceContext); !ok {
		return nil
	} else {
		retTctxs := make([]*TraceContext, 0)
		for _, tctx := range tctxs {
			if tctx != nil {
				retTctxs = append(retTctxs, tctx)
			}
		}
		return retTctxs
	}
}

func SetTraceContextsToContext(ctx context.Context, tctxs []*TraceContext) context.Context {
	return context.WithValue(ctx, kOC_TCTX_KEY, tctxs)
}

func AddTraceContextToContext(ctx context.Context, tctx *TraceContext) context.Context {
	tctxs := GetTraceContextsFromContext(ctx)
	tctxs = append(tctxs, tctx)
	return SetTraceContextsToContext(ctx, tctxs)
}

var (
	spanCh     chan *mergelogpb.Span
	mergelogCh chan *mergelogpb.Mergelog
)

const (
	CHANNEL_SIZE = 100
)

// InitSender initializes a sender (gRPC client).
// If wait is true, this func waits until setup is done.
func InitSender(endpoint string, timeout time.Duration, _numAncCpids int) (<-chan error, func()) {
	numAncCpids = _numAncCpids
	doneCh := make(chan struct{})
	spanCh = make(chan *mergelogpb.Span, CHANNEL_SIZE)
	mergelogCh = make(chan *mergelogpb.Mergelog, CHANNEL_SIZE)
	setupDoneCh := make(chan error)
	finishCh := make(chan struct{})
	go runSender(doneCh, endpoint, spanCh, mergelogCh, setupDoneCh, finishCh, timeout)

	return setupDoneCh, func() {
		doneCh <- struct{}{}
		// wait until sender is shutdown
		<-finishCh
	}
}

// Span is a span that is to be converted to the Span struct of protobuf
type Span struct {
	cpid       string
	startTime  time.Time
	endTime    time.Time
	service    string
	objectKind string
	objectName string
	message    string
	spanId     string
	parentId   string
}

// Start starts a span. If cpid == "" and ctx has no trace context, returns an error.
func Start(ctx context.Context, cpid, service, objKind, objName, msg string) (context.Context, *Span, error) {
	if cpid == "" {
		tctxs := GetTraceContextsFromContext(ctx)
		if len(tctxs) == 0 {
			return ctx, nil, fmt.Errorf("cpid = \"\", and no trace context found in ctx")
		}
		// TODO (REFACTOR): use all of tctxs instead of only one
		// TODO (REFACTOR) (idea): change Span to embrace multiple tctxs so that we don't need to merge tctxs here every time
		cpid = tctxs[0].GetCpid()
	}

	// 古いctxには、呼び出し側の関数のspanIdが入っている
	// newCtxには、出力されるspanと同じ情報が入っている
	spanId, _ := uuid.NewRandom()
	span := &Span{
		cpid:       cpid,
		startTime:  time.Now(),
		service:    service,
		objectKind: objKind,
		objectName: objName,
		message:    msg,
		spanId:     spanId.String(),             // 新しいspanIdを入れる
		parentId:   GetParentIdFromContext(ctx), // 古いctxのspanIdを入れる
	}
	newCtx := SetParentIdToContext(ctx, spanId.String())
	return newCtx, span, nil
}

// End ends a span
func (s *Span) End() {
	s.endTime = time.Now()
	// push to channel
	spanCh <- s.ToProtoSpan()
}

// GenerateNewTctxAndSendMergelog generates a new trace context. if retTctx is nil, no mergelog is sent.
func MergeAndSendMergelog(sourceTctxs []*TraceContext, causeMsg, by string) *TraceContext {
	return mergeAndSendMergelog(sourceTctxs, causeMsg, by)
}

// generateNewTctxAndSendMergelog generates a new trace context. if retTctx is nil, no mergelog is sent.
func mergeAndSendMergelog(sourceTctxs []*TraceContext, causeMsg, by string) *TraceContext {
	log.Println("EPPPPI-DEBUG: mergeAndSendMergelog() started")
	defer log.Println("EPPPPI-DEBUG: mergeAndSendMergelog() ended")
	newSourceTctxs := make([]*TraceContext, 0)
	for i := 0; i < len(sourceTctxs); i++ {
		if err := sourceTctxs[i].validateTctx(); err != nil {
			log.Println("validation error, skipping this tctx:", err)
		} else {
			newSourceTctxs = append(newSourceTctxs, sourceTctxs[i].DeepCopyTraceContext())
		}
	}
	if len(newSourceTctxs) == 0 {
		return nil
	} else if len(newSourceTctxs) == 1 {
		return newSourceTctxs[0]
	}

	retTctx, newCpid, sourceCpids := mergeTctxs(newSourceTctxs)
	log.Println("EPPPPI-DEBUG= retTctx in mergeAndSendMergelog():", retTctx)
	if sourceCpids != nil {
		err := sendMergelog(newCpid, sourceCpids, mergelogpb.CauseType_CAUSE_TYPE_MERGE, causeMsg, by)
		if err != nil {
			panic(err) // should not happen because of prior validation
		}
	}
	return retTctx
}

// GenerateAndSendMergelog generates a mergelog and push it to channel
func sendMergelog(newCpid string, sourceCpids []string, causeType mergelogpb.CauseType, causeMsg, by string) error {
	log.Println("EPPPPI-DEBUG: sendMergelog() invoked")
	// validate cpids
	if newCpid == "" {
		log.Println("EPPPPI-DEBUG (sendMergelog()): newCpid is empty string")
		return fmt.Errorf("newCpid is empty string")
	}
	for _, sourceCpid := range sourceCpids {
		if sourceCpid == "" {
			log.Println("EPPPPI-DEBUG (sendMergelog()): one of sourceCpid is empty string")
			return fmt.Errorf("one of sourceCpid is empty string")
		}
	}

	srcCpids := make([]*mergelogpb.CPID, 0)
	for _, cpid := range sourceCpids {
		srcCpids = append(srcCpids, &mergelogpb.CPID{Cpid: cpid})
	}
	mergelog := &mergelogpb.Mergelog{
		NewCpid:      &mergelogpb.CPID{Cpid: newCpid},
		SourceCpids:  srcCpids,
		Time:         timestamppb.New(time.Now()),
		CauseType:    causeType,
		CauseMessage: causeMsg,
		By:           by,
	}
	log.Println("EPPPPI-DEBUG: mergelog sent into mergelogCh")
	mergelogCh <- mergelog
	return nil
}

// ToProtoSpan converts a span to the Span struct of protobuf
func (s *Span) ToProtoSpan() *mergelogpb.Span {
	return &mergelogpb.Span{
		Cpid:       &mergelogpb.CPID{Cpid: s.cpid},
		StartTime:  timestamppb.New(s.startTime),
		EndTime:    timestamppb.New(s.endTime),
		Service:    s.service,
		ObjectKind: s.objectKind,
		ObjectName: s.objectName,
		Message:    s.message,
		SpanId:     s.spanId,
		ParentId:   s.parentId,
	}
}

// RunSender runs a sender.
// This func is intended to be called as a goroutine.
// ctx is a context that is used to stop this func.
func runSender(doneCh <-chan struct{}, endpoint string, spanCh <-chan *mergelogpb.Span, mergelogCh <-chan *mergelogpb.Mergelog, setupDoneCh chan<- error, finishCh chan<- struct{}, timeout time.Duration) {
	log.Println("runSender() started")
	ctx, cancel := context.WithTimeout(context.Background(), timeout)
	defer cancel()
	// TODO(improve): 毎回送信するのではなく、一定時間ごとに送信するようにする
	conn, err := grpc.DialContext(
		ctx,
		endpoint,
		grpc.WithTransportCredentials(insecure.NewCredentials()),
		grpc.WithBlock(),
	)
	if err != nil {
		setupDoneCh <- fmt.Errorf("connection failed: %v: the trace-server is not running or the endpoint is wrong", err)
		finishCh <- struct{}{}
		return
	} else {
		log.Println("Connection succeeded")
	}
	defer conn.Close()
	client := mergelogpb.NewMergelogServiceClient(conn)

	setupDoneCh <- nil
	log.Println("EPPPPI-DEBUG: runSender() setupDoneCh <- nil sent")

	for {
		select {
		case <-doneCh:
			// TODO: graceful shutdown (wait until all channels are empty)
			log.Println("finishing sender")
			finishCh <- struct{}{}
			return
		case span := <-spanCh:
			req := &mergelogpb.PostSpansRequest{
				Spans: []*mergelogpb.Span{span},
			}
			_, err := client.PostSpans(context.Background(), req)
			if err != nil {
				log.Println(err)
			}
		case mergelog := <-mergelogCh:
			req := &mergelogpb.MergelogRequest{
				Mergelogs: []*mergelogpb.Mergelog{mergelog},
			}
			_, err := client.PostMergelogs(context.Background(), req)
			if err != nil {
				log.Println(err)
			}
		}
	}
}
