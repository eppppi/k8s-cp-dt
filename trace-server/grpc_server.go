package main

import (
	"context"
	// "fmt"
	"sync"

	mergelogpb "github.com/eppppi/k8s-cp-dt/mergelog/src/pkg/grpc"
	emptypb "google.golang.org/protobuf/types/known/emptypb"
)

type traceServer struct {
	mergelogpb.UnimplementedMergelogServiceServer
}

// var mergelogList []*mergelogpb.Mergelog

type mergelogListStruct struct {
	list []*mergelogpb.Mergelog
	mu   sync.RWMutex
}

var mergelogList mergelogListStruct

func (ml *mergelogListStruct) append(mergelogs []*mergelogpb.Mergelog) {
	ml.mu.Lock()
	defer ml.mu.Unlock()
	ml.list = append(ml.list, mergelogs...)
}

func (ml *mergelogListStruct) getAll() []*mergelogpb.Mergelog {
	ml.mu.RLock()
	defer ml.mu.RUnlock()
	return ml.list
}

// Post receives the mergelogs from controllers
func (s *traceServer) Post(ctx context.Context, req *mergelogpb.MergelogRequest) (*emptypb.Empty, error) {
	incomingMergelogs := req.GetMergelogs()
	mergelogList.append(incomingMergelogs)
	return &emptypb.Empty{}, nil
}

// GetAllMergelogs gets all mergelogs stored in this trace server
func (s *traceServer) GetAllMergelogs(ctx context.Context, req *emptypb.Empty) (*mergelogpb.Mergelogs, error) {
	return &mergelogpb.Mergelogs{
		Mergelogs: mergelogList.getAll(),
	}, nil
}

// TOOD: implement
func (s *traceServer) GetRelevantMergelogs(ctx context.Context, req *mergelogpb.CPID) (*mergelogpb.Mergelogs, error) {
	return &mergelogpb.Mergelogs{}, nil
}

func NewTraceServer() *traceServer {
	mergelogList.list = make([]*mergelogpb.Mergelog, 0)
	return &traceServer{}
}
