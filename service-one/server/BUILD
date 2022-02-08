load("@io_bazel_rules_go//go:def.bzl", "go_library")

package(default_visibility = ["//visibility:public"])

go_library(
    name = "server",
    srcs = [
        "bye.go",
        "hello.go",
    ],
    importpath = "github.com/ekhabarov/bazel-k8s-envoy/service-one/server",
    deps = [
        "//service-one/pb",
        "@org_golang_google_grpc//:go_default_library",
        "@org_golang_google_grpc//metadata",
    ],
)
