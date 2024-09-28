load("@io_bazel_rules_go//go:def.bzl", "go_library")
load("@io_bazel_rules_go//proto:def.bzl", "go_proto_library")
load("@rules_proto//proto:defs.bzl", "proto_descriptor_set", "proto_library")

package(default_visibility = ["//visibility:public"])

# gazelle:resolve proto proto google/api/annotations.proto @googleapis//google/api:annotations_proto
# gazelle:resolve proto go google/api/annotations.proto @googleapis//google/api:annotations_go_proto

proto_library(
    name = "pb_proto",
    srcs = ["service-one.proto"],
    deps = ["@googleapis//google/api:annotations_proto"],
)

go_proto_library(
    name = "pb_go_proto",
    compilers = ["@io_bazel_rules_go//proto:go_grpc"],
    importpath = "github.com/ekhabarov/bazel-k8s-envoy/service-one/pb",
    proto = ":pb_proto",
    deps = ["@googleapis//google/api:annotations_go_proto"],
)

go_library(
    name = "pb",
    srcs = ["empty.go"],
    embed = [":pb_go_proto"],
    importpath = "github.com/ekhabarov/bazel-k8s-envoy/service-one/pb",
)

proto_descriptor_set(
    name = "service_one_descriptor_set",
    deps = [
        ":pb_proto",
        "@googleapis//google/api:annotations_proto",
    ],
)

