package instrumentation

import (
	"context"
	"fmt"
	"testing"
	"time"
)

func TestStart(t *testing.T) {
	// init sender
	done := make(chan struct{})
	defer close(done)
	InitSender(done, "localhost:10039")

	type args struct {
		ctx     context.Context
		cpid    string
		service string
		objKind string
		objName string
		msg     string
	}
	tests := []struct {
		name  string
		args  args
		want  context.Context
		want1 *Span
	}{
		// TODO: Add test cases.
		{
			name: "test1",
			args: args{
				ctx:     context.Background(),
				cpid:    "cpid-1",
				service: "test",
				objKind: "Dep",
				objName: "dep-1",
				msg:     "test",
			},
			want:  context.Background(),
			want1: &Span{},
		},
	}
	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			newCtx, span := Start(tt.args.ctx, tt.args.cpid, tt.args.service, tt.args.objKind, tt.args.objName, tt.args.msg)
			fmt.Println(newCtx, span)
			span.End()
		})
	}

	time.Sleep(10 * time.Second)
}

func TestGenerateAndSendMergelog(t *testing.T) {
	// init sender
	done := make(chan struct{})
	defer close(done)
	InitSender(done, "localhost:10039")

	type args struct {
		newCpid     string
		sourceCpids []string
		causeMsg    string
		by          string
	}
	tests := []struct {
		name string
		args args
	}{
		{
			name: "root-cpid-1",
			args: args{
				newCpid:     "cpid-alpha",
				sourceCpids: []string{},
				causeMsg:    "root-cpid-1",
				by:          "test-user",
			},
		},
		{
			name: "root-cpid-2",
			args: args{
				newCpid:     "cpid-beta",
				sourceCpids: []string{},
				causeMsg:    "root-cpid-2",
				by:          "test-user",
			},
		},
		{
			name: "merge",
			args: args{
				newCpid:     "cpid-gamma",
				sourceCpids: []string{"cpid-alpha", "cpid-beta"},
				causeMsg:    "merge",
				by:          "test-user",
			},
		},
	}
	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			GenerateAndSendMergelog(tt.args.newCpid, tt.args.sourceCpids, tt.args.causeMsg, tt.args.by)
		})
	}

	time.Sleep(10 * time.Second)
}
