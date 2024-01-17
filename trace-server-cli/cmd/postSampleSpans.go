/*
Copyright © 2024 NAME HERE <EMAIL ADDRESS>
*/
package cmd

import (
	"context"
	"fmt"
	"time"

	mergelogpb "github.com/eppppi/k8s-cp-dt/mergelog/src/pkg/grpc"
	"github.com/spf13/cobra"
	"google.golang.org/grpc"
	"google.golang.org/grpc/credentials/insecure"
	"google.golang.org/protobuf/types/known/timestamppb"
)

// postSampleSpansCmd represents the postSampleSpans command
var postSampleSpansCmd = &cobra.Command{
	Use:   "postSampleSpans",
	Short: "A brief description of your command",
	Long:  ``,
	Run: func(cmd *cobra.Command, args []string) {
		postSampleSpans(cmd)
	},
}

func init() {
	rootCmd.AddCommand(postSampleSpansCmd)
}

func postSampleSpans(cmd *cobra.Command) {
	address := cmd.Flag("endpoint").Value.String()
	conn, err := grpc.Dial(
		address,
		grpc.WithTransportCredentials(insecure.NewCredentials()),
		grpc.WithBlock(),
	)
	if err != nil {
		fmt.Println("Connection failed.")
		return
	}
	defer conn.Close()

	client := mergelogpb.NewMergelogServiceClient(conn)

	spanRequest := &mergelogpb.PostSpansRequest{
		Spans: []*mergelogpb.Span{
			{
				Cpid:       &mergelogpb.CPID{Cpid: "cpid-1"},
				StartTime:  timestamppb.New(time.Now().Add(-3 * time.Second)),
				EndTime:    timestamppb.New(time.Now()),
				Service:    "sample",
				ObjectKind: "sample-kind",
				ObjectName: "sample-name",
				Message:    "sample-message",
				SpanId:     "sample-span-id-1",
				ParentId:   "",
			},
			{
				Cpid:       &mergelogpb.CPID{Cpid: "cpid-1"},
				StartTime:  timestamppb.New(time.Now().Add(-2 * time.Second)),
				EndTime:    timestamppb.New(time.Now().Add(-1 * time.Second)),
				Service:    "sample",
				ObjectKind: "sample-kind",
				ObjectName: "sample-name",
				Message:    "sample-message",
				SpanId:     "sample-span-id-2",
				ParentId:   "sample-span-id-1",
			},
		},
	}
	_, err = client.PostSpans(context.Background(), spanRequest)
	if err != nil {
		fmt.Println(err)
	} else {
		fmt.Println("sent spans")
	}
}
