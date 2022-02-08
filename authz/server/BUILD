load("@io_bazel_rules_go//go:def.bzl", "go_library")

go_library(
    name = "server",
    srcs = ["server.go"],
    importpath = "github.com/ekhabarov/bazel-k8s-envoy/authz/server",
    visibility = ["//visibility:public"],
    deps = [
        "@com_github_envoyproxy_go_control_plane//envoy/config/core/v3:core",
        "@com_github_envoyproxy_go_control_plane//envoy/service/auth/v3:auth",
        "@com_github_envoyproxy_go_control_plane//envoy/type/v3:type",
        "@go_googleapis//google/rpc:status_go_proto",
        "@org_golang_google_grpc//codes",
    ],
)
