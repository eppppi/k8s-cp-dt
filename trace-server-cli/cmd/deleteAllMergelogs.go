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

// deleteAllMergelogsCmd represents the deleteAllMergelogs command
var deleteAllMergelogsCmd = &cobra.Command{
	Use:   "deleteAllMergelogs",
	Short: "A brief description of your command",
	Long:  ``,
	Run: func(cmd *cobra.Command, args []string) {
		deleteAllMergelogs(cmd)
	},
}

func init() {
	rootCmd.AddCommand(deleteAllMergelogsCmd)
}

func deleteAllMergelogs(cmd *cobra.Command) {
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

	_, err = client.DeleteAllMergelogs(context.Background(), &emptypb.Empty{})
	if err != nil {
		fmt.Println(err)
	} else {
		fmt.Println("All mergelogs are deleted.")
	}
}
