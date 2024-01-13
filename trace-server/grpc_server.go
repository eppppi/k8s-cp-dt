package main

import (
	"context"
	"log"
	"sync"

	mergelogpb "github.com/eppppi/k8s-cp-dt/mergelog/src/pkg/grpc"
	emptypb "google.golang.org/protobuf/types/known/emptypb"
)

type traceServer struct {
	mergelogpb.UnimplementedMergelogServiceServer
}

// all CPID must show up only once as NewCPID.
// ml has all mergelogs stored in this trace server,
// and mg represents the merge graph. (each node is a cpid, and each edge is from mergelog)
type mergeGraph struct {
	// REFACTOR: Is *mergelogpb.CPID the right type for key? -> No, it should be string.
	mg map[string][]*mergelogpb.Mergelog
	ml []*mergelogpb.Mergelog
	mu sync.RWMutex
}

var mg mergeGraph

func (mg *mergeGraph) add(mergelog *mergelogpb.Mergelog) {
	mg.mu.Lock()
	defer mg.mu.Unlock()
	for _, srcCpid := range mergelog.SourceCpids {
		mg.mg[srcCpid.GetCpid()] = append(mg.mg[srcCpid.GetCpid()], mergelog)
	}
	mg.ml = append(mg.ml, mergelog)
}

func (mg *mergeGraph) getAll() []*mergelogpb.Mergelog {
	mg.mu.RLock()
	defer mg.mu.RUnlock()
	return mg.ml
}

type spanListStruct struct {
	list []*mergelogpb.Span
	mu   sync.RWMutex
}

var spanList spanListStruct

func (ml *spanListStruct) append(spans []*mergelogpb.Span) {
	ml.mu.Lock()
	defer ml.mu.Unlock()
	ml.list = append(ml.list, spans...)
}

func (ml *spanListStruct) getAll() []*mergelogpb.Span {
	ml.mu.RLock()
	defer ml.mu.RUnlock()
	return ml.list
}

// Post receives the mergelogs from controllers
func (s *traceServer) PostMergelogs(ctx context.Context, req *mergelogpb.MergelogRequest) (*emptypb.Empty, error) {
	incomingMergelogs := req.GetMergelogs()
	for _, mergelog := range incomingMergelogs {
		mg.add(mergelog)
	}
	log.Println("mergelog received")
	return &emptypb.Empty{}, nil
}

// GetAllMergelogs gets all mergelogs stored in this trace server
func (s *traceServer) GetAllMergelogs(ctx context.Context, req *emptypb.Empty) (*mergelogpb.Mergelogs, error) {
	return &mergelogpb.Mergelogs{
		Mergelogs: mg.getAll(),
	}, nil
}

// TOOD: test
func (s *traceServer) GetRelevantMergelogs(ctx context.Context, req *mergelogpb.CPID) (*mergelogpb.Mergelogs, error) {
	// first, get all relevant descendant cpids
	descendantCPIDs := descendantCPIDs(req)
	if len(descendantCPIDs) == 0 {
		return &mergelogpb.Mergelogs{}, nil
	}

	// second, for each descendant cpid, get all mergelogs
	retMergelogs := make([]*mergelogpb.Mergelog, 0)
	allMergelogs := mg.getAll()
	for _, desCpid := range descendantCPIDs {
		for _, mergelog := range allMergelogs {
			if desCpid.GetCpid() == mergelog.GetNewCpid().GetCpid() {
				retMergelogs = append(retMergelogs, mergelog)
			}
		}
	}

	return &mergelogpb.Mergelogs{Mergelogs: retMergelogs}, nil
}

func (s *traceServer) PostSpans(ctx context.Context, req *mergelogpb.PostSpansRequest) (*emptypb.Empty, error) {
	incomingSpans := req.GetSpans()
	spanList.append(incomingSpans)
	log.Println("span received")
	return &emptypb.Empty{}, nil
}

func (s *traceServer) GetAllSpans(ctx context.Context, req *emptypb.Empty) (*mergelogpb.GetAllSpansResponse, error) {
	return &mergelogpb.GetAllSpansResponse{
		Spans: spanList.getAll(),
	}, nil
}

// TOOD: test
func (s *traceServer) GetRelevantSpans(ctx context.Context, req *mergelogpb.CPID) (*mergelogpb.GetRelevantSpansResponse, error) {
	// first, get all relevant descendant cpids
	descendantCPIDs := descendantCPIDs(req)
	if len(descendantCPIDs) == 0 {
		return &mergelogpb.GetRelevantSpansResponse{}, nil
	}

	// second, for each descendant cpid, get all spans
	retSpans := make([]*mergelogpb.Span, 0)
	allSpans := spanList.getAll()
	for _, desCpid := range descendantCPIDs {
		for _, span := range allSpans {
			if desCpid.GetCpid() == span.GetCpid().GetCpid() {
				retSpans = append(retSpans, span)
			}
		}
	}

	return &mergelogpb.GetRelevantSpansResponse{Spans: retSpans}, nil
}

func NewTraceServer() *traceServer {
	mg.mg = make(map[string][]*mergelogpb.Mergelog)
	mg.ml = make([]*mergelogpb.Mergelog, 0)
	return &traceServer{}
}

// descendantCPIDs returns all descendant cpids of the given cpid including itself
func descendantCPIDs(cpid *mergelogpb.CPID) []*mergelogpb.CPID {
	// find a mergelog that has the given cpid as a NewCPID
	// if not found, from the rules of merge graph, no such cpid exists
	if _, ok := mg.mg[cpid.GetCpid()]; !ok {
		return nil
	}

	visitedCpids := make(map[*mergelogpb.CPID]struct{})
	queue := make([]*mergelogpb.CPID, 0)
	queue = append(queue, cpid)
	for len(queue) > 0 {
		curCpid := queue[0]
		queue = queue[1:]
		visitedCpids[curCpid] = struct{}{}
		for _, mergelog := range mg.mg[curCpid.GetCpid()] {
			queue = append(queue, mergelog.GetNewCpid())
		}
	}

	retCpids := make([]*mergelogpb.CPID, 0, len(visitedCpids))
	for k := range visitedCpids {
		retCpids = append(retCpids, k)
	}
	return retCpids
}
