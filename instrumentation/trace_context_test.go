package instrumentation

import (
	"fmt"
	"reflect"
	"testing"
)

func TestTraceContext_validateTctx(t *testing.T) {
	type fields struct {
		Cpid     string
		AncCpids []string
	}
	tooLongAncCpids := make([]string, 0)
	for i := 0; i < NUM_ANC_CPIDS+1; i++ {
		tooLongAncCpids = append(tooLongAncCpids, fmt.Sprintf("cpid-%d", i))
	}
	tests := []struct {
		name    string
		fields  fields
		wantErr bool
	}{
		{
			name: "empty-cpid",
			fields: fields{
				Cpid:     "",
				AncCpids: nil,
			},
			wantErr: true,
		},
		{
			name: "too-long-ancCpids",
			fields: fields{
				Cpid:     "cpid",
				AncCpids: tooLongAncCpids,
			},
			wantErr: true,
		},
		{
			name: "cpid-included-in-ancCpids",
			fields: fields{
				Cpid:     "cpid",
				AncCpids: []string{"cpid", "other-cpid-1", "other-cpid-2"},
			},
			wantErr: true,
		},
		{
			name: "valid-1",
			fields: fields{
				Cpid:     "cpid",
				AncCpids: []string{},
			},
		},
		{
			name: "valid-2",
			fields: fields{
				Cpid:     "cpid",
				AncCpids: []string{"anc-cpid-1", "anc-cpid-2"},
			},
		},
	}
	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			tctx := &TraceContext{
				Cpid:     tt.fields.Cpid,
				AncCpids: tt.fields.AncCpids,
			}
			if err := tctx.validateTctx(); (err != nil) != tt.wantErr {
				t.Errorf("TraceContext.validateTctx() error = %v, wantErr %v", err, tt.wantErr)
			}
		})
	}
}

func Test_mergeTctxs(t *testing.T) {
	sampleCpid, _ := generateCpid()
	lenOfGeneratedCpid := len(sampleCpid)
	const GENERATED_CPID_MOCK = "GENERATED_CPID_MOCK"
	type args struct {
		tctxs []*TraceContext
	}
	tests := []struct {
		name            string
		args            args
		wantRetTctx     *TraceContext
		wantNewCpid     string
		wantSourceCpids []string
	}{
		{
			name: "nil",
			args: args{
				tctxs: nil,
			},
			wantRetTctx:     nil,
			wantNewCpid:     "",
			wantSourceCpids: nil,
		},
		{
			name: "empty",
			args: args{
				tctxs: []*TraceContext{},
			},
			wantRetTctx:     nil,
			wantNewCpid:     "",
			wantSourceCpids: nil,
		},
		{
			name: "invalid-tctx",
			args: args{
				tctxs: []*TraceContext{
					{
						Cpid:     "",
						AncCpids: []string{},
					},
				},
			},
			wantRetTctx:     nil,
			wantNewCpid:     "",
			wantSourceCpids: nil,
		},
		{
			name: "valid-1",
			args: args{
				tctxs: []*TraceContext{
					{
						Cpid:     "cpid-1",
						AncCpids: []string{},
					},
				},
			},
			wantRetTctx: &TraceContext{
				Cpid:     "cpid-1",
				AncCpids: []string{},
			},
			wantNewCpid:     "cpid-1",
			wantSourceCpids: nil,
		},
		{
			name: "valid-2",
			args: args{
				tctxs: []*TraceContext{
					{
						Cpid:     "cpid-1",
						AncCpids: []string{"cpid-2", "cpid-3"},
					},
				},
			},
			wantRetTctx: &TraceContext{
				Cpid:     "cpid-1",
				AncCpids: []string{"cpid-2", "cpid-3"},
			},
			wantNewCpid:     "cpid-1",
			wantSourceCpids: nil,
		},
		{
			name: "valid-3",
			args: args{
				tctxs: []*TraceContext{
					{
						Cpid:     "cpid-1",
						AncCpids: []string{"cpid-2", "cpid-3"},
					},
					{
						Cpid:     "cpid-4",
						AncCpids: []string{"cpid-5", "cpid-6"},
					},
				},
			},
			wantRetTctx: &TraceContext{
				Cpid:     GENERATED_CPID_MOCK,
				AncCpids: []string{"cpid-1", "cpid-2", "cpid-3", "cpid-4", "cpid-5", "cpid-6"},
			},
			wantNewCpid:     GENERATED_CPID_MOCK,
			wantSourceCpids: []string{"cpid-1", "cpid-4"},
		},
		{
			name: "valid-4",
			args: args{
				tctxs: []*TraceContext{
					{
						Cpid:     "cpid-1",
						AncCpids: []string{"cpid-2", "cpid-3"},
					},
					{
						Cpid:     "cpid-4",
						AncCpids: []string{"cpid-5", "cpid-6"},
					},
					{
						Cpid:     "cpid-7",
						AncCpids: []string{"cpid-8", "cpid-9"},
					},
				},
			},
			wantRetTctx: &TraceContext{
				Cpid:     GENERATED_CPID_MOCK,
				AncCpids: []string{"cpid-1", "cpid-2", "cpid-3", "cpid-4", "cpid-5", "cpid-6", "cpid-7", "cpid-8", "cpid-9"},
			},
			wantNewCpid:     GENERATED_CPID_MOCK,
			wantSourceCpids: []string{"cpid-1", "cpid-4", "cpid-7"},
		},
	}
	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			gotRetTctx, gotNewCpid, gotSourceCpids := mergeTctxs(tt.args.tctxs)
			if gotRetTctx != nil && len(gotRetTctx.Cpid) != lenOfGeneratedCpid && !reflect.DeepEqual(gotRetTctx.AncCpids, tt.wantRetTctx.AncCpids) {
				t.Errorf("mergeTctxs() gotRetTctx = %v, want %v", gotRetTctx, tt.wantRetTctx)
			}
			if tt.wantNewCpid == GENERATED_CPID_MOCK {
				if len(gotNewCpid) != lenOfGeneratedCpid {
					t.Errorf("mergeTctxs() gotNewCpid = %v is invalid, not generated one", gotNewCpid)
				}
			} else {
				if gotNewCpid != tt.wantNewCpid {
					t.Errorf("mergeTctxs() gotNewCpid = %v, want %v", gotNewCpid, tt.wantNewCpid)
				}
			}
			// if !reflect.DeepEqual(gotRetTctx, tt.wantRetTctx) {
			// 	t.Errorf("mergeTctxs() gotRetTctx = %v, want %v", gotRetTctx, tt.wantRetTctx)
			// }
			if !reflect.DeepEqual(gotSourceCpids, tt.wantSourceCpids) {
				t.Errorf("mergeTctxs() gotSourceCpids = %v, want %v", gotSourceCpids, tt.wantSourceCpids)
			}
		})
	}
}

// WARN: These tests work when NUM_ANC_CPIDS == 10
func Test_cpidGraph_addTraceContext(t *testing.T) {
	type fields struct {
		roots map[string][]string
	}
	type args struct {
		tctx *TraceContext
	}
	defaultEmptyCpidGraph := newEmptyCpidGraph()
	tests := []struct {
		name   string
		fields fields
		args   args
		want   *cpidGraph
	}{
		{
			name: "tctx-is-nil",
			fields: fields{
				roots: defaultEmptyCpidGraph.roots,
			},
			args: args{
				tctx: nil,
			},
			want: defaultEmptyCpidGraph,
		},
		{
			name: "empty-tctx",
			fields: fields{
				roots: defaultEmptyCpidGraph.roots,
			},
			args: args{
				tctx: newTraceContext("", []string{}),
			},
			want: defaultEmptyCpidGraph,
		},
		{
			name: "case-0",
			fields: fields{
				roots: defaultEmptyCpidGraph.roots,
			},
			args: args{
				tctx: &TraceContext{
					Cpid:     "cpid-1",
					AncCpids: []string{"cpid-2", "cpid-3"},
				},
			},
			want: &cpidGraph{
				roots: map[string][]string{
					"cpid-1": {"cpid-2", "cpid-3"},
				},
			},
		},
		{
			name: "case-1",
			fields: fields{
				roots: map[string][]string{
					"cpid-1": {"cpid-2", "cpid-3"},
				},
			},
			args: args{
				tctx: &TraceContext{
					Cpid:     "cpid-1",
					AncCpids: []string{"cpid-4", "cpid-5"},
				},
			},
			want: &cpidGraph{
				roots: map[string][]string{
					"cpid-1": {"cpid-4", "cpid-5", "cpid-2", "cpid-3"},
				},
			},
		},
		{
			name: "case-2",
			fields: fields{
				roots: map[string][]string{
					"cpid-1": {"cpid-2", "cpid-3"},
					"cpid-4": {"cpid-5", "cpid-6"},
				},
			},
			args: args{
				tctx: &TraceContext{
					Cpid:     "cpid-1",
					AncCpids: []string{"cpid-4"},
				},
			},
			want: &cpidGraph{
				roots: map[string][]string{
					"cpid-1": {"cpid-4", "cpid-5", "cpid-6", "cpid-2", "cpid-3"},
				},
			},
		},
		{
			name: "case-3",
			fields: fields{
				roots: map[string][]string{
					"cpid-1": {"cpid-2", "cpid-3"},
				},
			},
			args: args{
				tctx: &TraceContext{
					Cpid:     "cpid-1",
					AncCpids: []string{"cpid-2", "cpid-3"},
				},
			},
			want: &cpidGraph{
				roots: map[string][]string{
					"cpid-1": {"cpid-2", "cpid-3"},
				},
			},
		},
	}
	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			cg := &cpidGraph{
				roots: tt.fields.roots,
			}
			cg.addTraceContext(tt.args.tctx)
			if !reflect.DeepEqual(cg, tt.want) {
				t.Errorf("cg.addTraceContext(); cg = %v, want %v", cg, tt.want)
			}

		})
	}
}
