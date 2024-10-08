package main

import (
	"net"

	"github.com/ekhabarov/bazel-k8s-envoy/authz/server"
	auth "github.com/envoyproxy/go-control-plane/envoy/service/auth/v3"
	"google.golang.org/grpc"
	"google.golang.org/grpc/reflection"
)

func main() {
	s := grpc.NewServer()
	auth.RegisterAuthorizationServer(s, &server.Server{})
	reflection.Register(s)

	lis, err := net.Listen("tcp", ":5000")
	if err != nil {
		return
	}

	s.Serve(lis)
}
