package main

import (
	"context"
	"reflect"
	"testing"

	mergelogpb "github.com/eppppi/k8s-cp-dt/mergelog/src/pkg/grpc"
)

func Test_descendantCPIDs(t *testing.T) {
	s := NewTraceServer()
	mergelogs := []*mergelogpb.Mergelog{
		{
			NewCpid: &mergelogpb.CPID{Cpid: "1"},
		},
		{
			NewCpid: &mergelogpb.CPID{Cpid: "2"},
		},
		{
			NewCpid:     &mergelogpb.CPID{Cpid: "3"},
			SourceCpids: []*mergelogpb.CPID{{Cpid: "1"}, {Cpid: "2"}},
		},
		{
			NewCpid: &mergelogpb.CPID{Cpid: "4"},
		},
		{
			NewCpid:     &mergelogpb.CPID{Cpid: "5"},
			SourceCpids: []*mergelogpb.CPID{{Cpid: "2"}, {Cpid: "4"}},
		},
		{
			NewCpid:     &mergelogpb.CPID{Cpid: "6"},
			SourceCpids: []*mergelogpb.CPID{{Cpid: "3"}, {Cpid: "5"}},
		},
		{
			NewCpid: &mergelogpb.CPID{Cpid: "7"},
		},
		{
			NewCpid:     &mergelogpb.CPID{Cpid: "8"},
			SourceCpids: []*mergelogpb.CPID{{Cpid: "3"}, {Cpid: "7"}},
		},
		{
			NewCpid: &mergelogpb.CPID{Cpid: "9"},
		},
		{
			NewCpid: &mergelogpb.CPID{Cpid: "10"},
		},
		{
			NewCpid:     &mergelogpb.CPID{Cpid: "11"},
			SourceCpids: []*mergelogpb.CPID{{Cpid: "9"}, {Cpid: "10"}},
		},
		{
			NewCpid: &mergelogpb.CPID{Cpid: "12"},
		},
		{
			NewCpid: &mergelogpb.CPID{Cpid: "13"},
		},
	}
	_, _ = s.PostMergelogs(context.TODO(), &mergelogpb.MergelogRequest{Mergelogs: mergelogs})
	// fmt.Printf("%v\n", mg.ml)
	// fmt.Printf("%v\n", mg.mg)

	type args struct {
		cpid *mergelogpb.CPID
	}
	tests := []struct {
		name string
		args args
		want []*mergelogpb.CPID
	}{
		{
			name: "nil",
			args: args{cpid: nil},
			want: nil,
		},
		{
			name: "empty",
			args: args{cpid: &mergelogpb.CPID{Cpid: ""}},
			want: nil,
		},
		{
			name: "no-such-cpid",
			args: args{cpid: &mergelogpb.CPID{Cpid: "NO-SUCH-CPID"}},
			want: nil,
		},
		{
			name: "1",
			args: args{cpid: &mergelogpb.CPID{Cpid: "1"}},
			want: []*mergelogpb.CPID{{Cpid: "1"}, {Cpid: "3"}, {Cpid: "6"}, {Cpid: "8"}},
		},
		{
			name: "2",
			args: args{cpid: &mergelogpb.CPID{Cpid: "2"}},
			want: []*mergelogpb.CPID{{Cpid: "2"}, {Cpid: "3"}, {Cpid: "5"}, {Cpid: "6"}, {Cpid: "8"}},
		},
		{
			name: "3",
			args: args{cpid: &mergelogpb.CPID{Cpid: "3"}},
			want: []*mergelogpb.CPID{{Cpid: "3"}, {Cpid: "6"}, {Cpid: "8"}},
		},
		{
			name: "4",
			args: args{cpid: &mergelogpb.CPID{Cpid: "4"}},
			want: []*mergelogpb.CPID{{Cpid: "4"}, {Cpid: "5"}, {Cpid: "6"}},
		},
		{
			name: "5",
			args: args{cpid: &mergelogpb.CPID{Cpid: "5"}},
			want: []*mergelogpb.CPID{{Cpid: "5"}, {Cpid: "6"}},
		},
		{
			name: "6",
			args: args{cpid: &mergelogpb.CPID{Cpid: "6"}},
			want: []*mergelogpb.CPID{{Cpid: "6"}},
		},
		{
			name: "7",
			args: args{cpid: &mergelogpb.CPID{Cpid: "7"}},
			want: []*mergelogpb.CPID{{Cpid: "7"}, {Cpid: "8"}},
		},
		{
			name: "8",
			args: args{cpid: &mergelogpb.CPID{Cpid: "8"}},
			want: []*mergelogpb.CPID{{Cpid: "8"}},
		},
		{
			name: "9",
			args: args{cpid: &mergelogpb.CPID{Cpid: "9"}},
			want: []*mergelogpb.CPID{{Cpid: "9"}, {Cpid: "11"}},
		},
		{
			name: "10",
			args: args{cpid: &mergelogpb.CPID{Cpid: "10"}},
			want: []*mergelogpb.CPID{{Cpid: "10"}, {Cpid: "11"}},
		},
		{
			name: "11",
			args: args{cpid: &mergelogpb.CPID{Cpid: "11"}},
			want: []*mergelogpb.CPID{{Cpid: "11"}},
		},
		{
			name: "12",
			args: args{cpid: &mergelogpb.CPID{Cpid: "12"}},
			want: []*mergelogpb.CPID{{Cpid: "12"}},
		},
	}
	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			got := descendantCPIDs(tt.args.cpid)
			gotCpidMap := make(map[*mergelogpb.CPID]struct{})
			for _, v := range got {
				gotCpidMap[v] = struct{}{}
			}
			wantCpidMap := make(map[*mergelogpb.CPID]struct{})
			for _, v := range tt.want {
				wantCpidMap[v] = struct{}{}
			}
			if !reflect.DeepEqual(gotCpidMap, wantCpidMap) {
				// t.Errorf("descendantCPIDs() = %v, want %v", got, tt.want)
				for kGot := range gotCpidMap {
					found := false
					for kWant := range wantCpidMap {
						if kGot.Cpid == kWant.Cpid {
							found = true
							break
						}
					}
					if !found {
						t.Errorf("descendantCPIDs() = %v, want %v", got, tt.want)
						return
					}
				}
			}
		})
	}
}
