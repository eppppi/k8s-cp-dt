/*
Copyright © 2024 NAME HERE <EMAIL ADDRESS>
*/
package cmd

import (
	"context"
	"fmt"
	"log"

	mergelogpb "github.com/eppppi/k8s-cp-dt/mergelog/src/pkg/grpc"
	clilib "github.com/eppppi/k8s-cp-dt/trace-server-cli/lib"
	"github.com/spf13/cobra"
	"google.golang.org/grpc"
	"google.golang.org/grpc/credentials/insecure"
	"google.golang.org/protobuf/types/known/emptypb"
)

// getAllSpansCmd represents the getAllSpans command
var getAllSpansCmd = &cobra.Command{
	Use:   "getAllSpans",
	Short: "get all spans",
	Long:  ``,
	Run: func(cmd *cobra.Command, args []string) {
		getAllSpans(cmd)
	},
}

func init() {
	rootCmd.AddCommand(getAllSpansCmd)
}

func getAllSpans(cmd *cobra.Command) {
	address := cmd.Flag("endpoint").Value.String()
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
	res, err := client.GetAllSpans(context.Background(), &emptypb.Empty{})
	if err != nil {
		fmt.Println(err)
	} else {
		spans := res.GetSpans()
		for _, span := range spans {
			clilib.PrettyPrintSpan(span)
			fmt.Println("------------------------------------")
		}
	}
}
