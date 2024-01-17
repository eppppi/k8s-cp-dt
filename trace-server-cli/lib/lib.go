package lib

import (
	"fmt"

	mergelogpb "github.com/eppppi/k8s-cp-dt/mergelog/src/pkg/grpc"
)

func PrettyPrintMergelog(mergelog *mergelogpb.Mergelog) {
	fmt.Println(mergelog.GetNewCpid())
	fmt.Println(mergelog.GetSourceCpids())
	fmt.Println(mergelog.GetTime().AsTime())
	fmt.Println(mergelog.GetCauseType().String())
	fmt.Println(mergelog.GetCauseMessage())
	fmt.Println(mergelog.GetBy())
}

func PrettyPrintSpan(span *mergelogpb.Span) {
	fmt.Println("cpid:\t", span.GetCpid().GetCpid())
	fmt.Println("start time:\t", span.GetStartTime().AsTime())
	fmt.Println("end time:\t", span.GetEndTime().AsTime())
	fmt.Println("service:\t", span.GetService())
	fmt.Println("object kind:\t", span.GetObjectKind())
	fmt.Println("object name:\t", span.GetObjectName())
	fmt.Println("message:\t", span.GetMessage())
	fmt.Println("span id:\t", span.GetSpanId())
	fmt.Println("parent id:\t", span.GetParentId())
}
