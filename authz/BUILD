load("@io_bazel_rules_go//go:def.bzl", "go_binary", "go_library")
load("@io_bazel_rules_docker//container:container.bzl", "container_image", "container_push")
load("@com_github_ebay_rules_ytt//:def.bzl", "ytt")

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
    goarch = "amd64",
    goos = "linux",
    visibility = ["//visibility:public"],
)

container_image(
    name = "image",
    base = "@go_base//image",
    entrypoint = ["/authz"],
    files = [
        ":authz",
    ],
    ports = [
        "5000/tcp",
    ],
)

ytt(
    name = "yaml",
    srcs = [
        "//k8s:defaults.yaml",
        "//k8s/base:service.yaml",
        ":values.yaml",
    ],
    image = ":image.digest",
)

container_push(
    name = "push_image",
    format = "Docker",
    image = ":image",
    registry = "ghcr.io",
    repository = "ekhabarov/authz",
    tag = "$(IMAGE_TAG)",
)
