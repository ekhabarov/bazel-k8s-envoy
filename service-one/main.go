package main

import (
	"net"

	"github.com/ekhabarov/bazel-k8s-envoy/service-one/pb"
	"github.com/ekhabarov/bazel-k8s-envoy/service-one/server"
	"google.golang.org/grpc"
	"google.golang.org/grpc/reflection"
)

func main() {
	s := grpc.NewServer()
	pb.RegisterServiceOneServer(s, &server.Server{})
	reflection.Register(s)

	lis, err := net.Listen("tcp", ":5000")
	if err != nil {
		return
	}

	s.Serve(lis)
}
