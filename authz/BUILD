load("@io_bazel_rules_go//go:def.bzl", "go_binary", "go_library")
load("@io_bazel_rules_docker//go:image.bzl", "go_image")
load("@io_bazel_rules_k8s//k8s:object.bzl", "k8s_object")
load("//:helpers.bzl", "namespace")

go_library(
    name = "authz_lib",
    srcs = ["main.go"],
    importpath = "github.com/ekhabarov/bazel-k8s-envoy/authz",
    visibility = ["//visibility:private"],
    deps = [
        "//authz/server",
        "@com_github_envoyproxy_go_control_plane//envoy/service/auth/v3:auth",
        "@org_golang_google_grpc//:go_default_library",
    ],
)

go_binary(
    name = "authz",
    embed = [":authz_lib"],
    visibility = ["//visibility:public"],
)

go_image(
    name = "image",
    embed = ["authz_lib"],
    importpath = "github.com/ekhabarov/bazel-k8s-envoy/authz",
)

k8s_object(
    name = "yaml",
    kind = "deployment",
    substitutions = {
        "%{apiname}": "authz",
        "%{namespace}": namespace(),
    },
    template = "//k8s:api-deployment-yaml",
)
