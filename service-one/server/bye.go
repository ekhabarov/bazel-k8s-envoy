package server

import (
	"context"
	"fmt"

	"github.com/ekhabarov/bazel-k8s-envoy/service-one/pb"
	"google.golang.org/grpc"
	"google.golang.org/grpc/metadata"
)

func (s *Server) Bye(ctx context.Context, req *pb.ByeRequest) (*pb.ByeResponse, error) {
	md, ok := metadata.FromIncomingContext(ctx)
	if ok {
		fmt.Println("=== metadata ===")
		for k, v := range md {
			fmt.Printf("%s: %#v\n", k, v)
		}
		fmt.Println("================")
	}

	header := metadata.Pairs("set-cookie", "service-one")
	grpc.SendHeader(ctx, header)

	return &pb.ByeResponse{
		Msg: "Bye bye, " + req.Name,
	}, nil
}
