/*
Copyright © 2023 NAME HERE <EMAIL ADDRESS>
*/
package cmd

import (
	"context"
	"fmt"
	"log"

	mergelogpb "github.com/eppppi/k8s-cp-dt/mergelog/src/pkg/grpc"
	"github.com/spf13/cobra"
	"google.golang.org/grpc"
	"google.golang.org/grpc/credentials/insecure"
	"google.golang.org/protobuf/types/known/emptypb"
)

// getAllMergelogsCmd represents the getAllMergelogs command
var getAllMergelogsCmd = &cobra.Command{
	Use:   "getAllMergelogs",
	Short: "get all mergelogs",
	Long: `A longer description that spans multiple lines and likely contains examples
and usage of using your command. For example:`,
	Run: func(cmd *cobra.Command, args []string) {
		getAllMergelogs()
	},
}

func init() {
	rootCmd.AddCommand(getAllMergelogsCmd)
}

func getAllMergelogs() {
	address := "localhost:10039"
	conn, err := grpc.Dial(
		address,
		grpc.WithTransportCredentials(insecure.NewCredentials()),
		grpc.WithBlock(),
	)
	if err != nil {
		log.Fatal("Connection failed.")
		return
	}
	defer conn.Close()

	client := mergelogpb.NewMergelogServiceClient(conn)

	// logic
	res, err := client.GetAllMergelogs(context.Background(), &emptypb.Empty{})
	if err != nil {
		fmt.Println(err)
	} else {
		fmt.Println(res.GetMergelogs())
	}
}
