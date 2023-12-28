package main

import (
	"fmt"
	"google.golang.org/grpc"
	"log"
	"net"
	"net/http"
	"os"
	"os/signal"

	mergelogpb "github.com/eppppi/k8s-cp-dt/mergelog/src/pkg/grpc"
	"google.golang.org/grpc/reflection"
)

const (
	GRPC_PORT = 10039
	WEB_PORT  = 10040
)

func main() {
	// ------- gRPC server -------
	listener, err := net.Listen("tcp", fmt.Sprintf(":%d", GRPC_PORT))
	if err != nil {
		panic(err)
	}
	s := grpc.NewServer()
	mergelogpb.RegisterMergelogServiceServer(s, NewTraceServer())

	// setup server reflection
	reflection.Register(s)

	// start gRPC server
	go func() {
		log.Printf("start gRPC server port: %v", GRPC_PORT)
		s.Serve(listener)
	}()

	// ------- web server -------
	http.HandleFunc("/", rootHandler)
	http.Handle("/assets/", http.StripPrefix("/assets/", http.FileServer(http.Dir("assets"))))
	http.HandleFunc("/get-all-mergelogs", getAllMergelogsHandler)
	http.HandleFunc("/get-all-mergelogs-image", getAllMergelogsImageHandler)
	http.HandleFunc("/get-relevant-mergelogs", getRelevantMergelogsHandler)
	http.HandleFunc("/get-relevant-mergelogs-image", getRelevantMergelogsImageHandler)

	// start web server
	go func() {
		log.Printf("start web server port: %v", WEB_PORT)
		log.Fatal(http.ListenAndServe(fmt.Sprintf(":%d", WEB_PORT), nil))
	}()

	// graceful shutdown when Ctrl+C
	quit := make(chan os.Signal, 1)
	signal.Notify(quit, os.Interrupt)
	<-quit
	log.Println("stopping gRPC server...")
	s.GracefulStop()
	log.Println("stopping web server...")
	// TODO: stop web server gracefully

}
