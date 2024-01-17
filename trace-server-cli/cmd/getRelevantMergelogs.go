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
)

// getRelevantMergelogsCmd represents the getRelevantMergelogs command
var getRelevantMergelogsCmd = &cobra.Command{
	Use:   "getRelevantMergelogs",
	Short: "A brief description of your command",
	Long:  ``,
	Run: func(cmd *cobra.Command, args []string) {
		getRelevantMergelogs(cmd)
	},
}

func init() {
	rootCmd.AddCommand(getRelevantMergelogsCmd)
	getRelevantMergelogsCmd.PersistentFlags().String("cpid", "", "original cpid of the relevant mergelogs")
}

func getRelevantMergelogs(cmd *cobra.Command) {
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
		log.Fatal("Connection failed.")
		return
	}
	defer conn.Close()

	client := mergelogpb.NewMergelogServiceClient(conn)

	request := &mergelogpb.CPID{Cpid: cpid}

	res, err := client.GetRelevantMergelogs(context.Background(), request)
	if err != nil {
		fmt.Println(err)
	} else {
		mergelogs := res.GetMergelogs()
		for _, mergelog := range mergelogs {
			clilib.PrettyPrintMergelog(mergelog)
			fmt.Println("------------------------------------")
		}
	}
}
