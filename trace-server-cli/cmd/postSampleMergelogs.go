/*
Copyright © 2023 NAME HERE <EMAIL ADDRESS>
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

// postSampleMergelogsCmd represents the postSampleMergelogs command
var postSampleMergelogsCmd = &cobra.Command{
	Use:   "postSampleMergelogs",
	Short: "A brief description of your command",
	Long:  ``,
	Run: func(cmd *cobra.Command, args []string) {
		postSampleMergelogs(cmd)
	},
}

func init() {
	rootCmd.AddCommand(postSampleMergelogsCmd)
	postSampleMergelogsCmd.Flags().String("endpoint", "localhost:10039", "endpoint of trace-server")
}

func postSampleMergelogs(cmd *cobra.Command) {
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

	// logic
	mergelogRequest := mergelogpb.MergelogRequest{
		Mergelogs: []*mergelogpb.Mergelog{
			{
				NewCpid:      &mergelogpb.CPID{Cpid: "cpid-1"},
				SourceCpids:  []*mergelogpb.CPID{},
				Time:         timestamppb.New(time.Now().Add(-2 * time.Second)),
				CauseType:    mergelogpb.CauseType_CAUSE_TYPE_NEW_CHANGE,
				CauseMessage: "new change 1!",
				By:           "cli-sample",
			},
			{
				NewCpid:      &mergelogpb.CPID{Cpid: "cpid-2"},
				SourceCpids:  []*mergelogpb.CPID{},
				Time:         timestamppb.New(time.Now().Add(-1 * time.Second)),
				CauseType:    mergelogpb.CauseType_CAUSE_TYPE_NEW_CHANGE,
				CauseMessage: "new change 2!",
				By:           "cli-sample",
			},
			{
				NewCpid: &mergelogpb.CPID{Cpid: "cpid-3"},
				SourceCpids: []*mergelogpb.CPID{
					{Cpid: "cpid-1"},
					{Cpid: "cpid-2"},
				},
				Time:         timestamppb.New(time.Now()),
				CauseType:    mergelogpb.CauseType_CAUSE_TYPE_MERGE,
				CauseMessage: "merge {1,2}->3",
				By:           "cli-sample",
			},
		},
	}
	_, err = client.PostMergelogs(context.Background(), &mergelogRequest)
	if err != nil {
		fmt.Println(err)
	} else {
		fmt.Println("sent")
	}
}
