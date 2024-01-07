package instrumentation

import (
	"context"
	"fmt"
	"testing"
	"time"
)

func TestStart(t *testing.T) {
	// init sender
	setupDoneCh, cancel := InitSender("localhost:10039")
	<-setupDoneCh
	defer cancel()

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
