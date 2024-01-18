/*
Copyright © 2024 NAME HERE <EMAIL ADDRESS>
*/
package cmd

import (
	"context"
	"fmt"

	mergelogpb "github.com/eppppi/k8s-cp-dt/mergelog/src/pkg/grpc"
	"github.com/spf13/cobra"
	"google.golang.org/grpc"
	"google.golang.org/grpc/credentials/insecure"
	"google.golang.org/protobuf/types/known/emptypb"
)

// deleteAllSpansCmd represents the deleteAllSpans command
var deleteAllSpansCmd = &cobra.Command{
	Use:   "deleteAllSpans",
	Short: "A brief description of your command",
	Long:  ``,
	Run: func(cmd *cobra.Command, args []string) {
		deleteAllSpans(cmd)
	},
}

func init() {
	rootCmd.AddCommand(deleteAllSpansCmd)
}

func deleteAllSpans(cmd *cobra.Command) {
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

	_, err = client.DeleteAllSpans(context.Background(), &emptypb.Empty{})
	if err != nil {
		fmt.Println(err)
	} else {
		fmt.Println("All spans are deleted.")
	}
}
