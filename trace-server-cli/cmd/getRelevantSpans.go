/*
Copyright © 2024 NAME HERE <EMAIL ADDRESS>
*/
package cmd

import (
	"context"
	"fmt"

	mergelogpb "github.com/eppppi/k8s-cp-dt/mergelog/src/pkg/grpc"
	clilib "github.com/eppppi/k8s-cp-dt/trace-server-cli/lib"
	"github.com/spf13/cobra"
	"google.golang.org/grpc"
	"google.golang.org/grpc/credentials/insecure"
)

// getRelevantSpansCmd represents the getRelevantSpans command
var getRelevantSpansCmd = &cobra.Command{
	Use:   "getRelevantSpans",
	Short: "A brief description of your command",
	Long:  ``,
	Run: func(cmd *cobra.Command, args []string) {
		getRelevantSpans(cmd)
	},
}

func init() {
	rootCmd.AddCommand(getRelevantSpansCmd)
	getRelevantSpansCmd.PersistentFlags().String("cpid", "", "original cpid of the relevant mergelogs")
}

func getRelevantSpans(cmd *cobra.Command) {
	cpid := cmd.Flag("cpid").Value.String()
	if cpid == "" {
		fmt.Println("cpid is required")
		return
	}
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

	request := &mergelogpb.CPID{Cpid: cpid}

	res, err := client.GetRelevantSpans(context.Background(), request)
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
