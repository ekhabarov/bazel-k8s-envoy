load("@io_bazel_rules_go//go:def.bzl", "go_binary", "go_library")
load("@io_bazel_rules_docker//container:container.bzl", "container_image", "container_push")
load("@com_github_ebay_rules_ytt//:def.bzl", "ytt")

go_library(
    name = "service-one_lib",
    srcs = ["main.go"],
    importpath = "github.com/ekhabarov/bazel-k8s-envoy/service-one",
    visibility = ["//visibility:private"],
    deps = [
        "//service-one/pb",
        "//service-one/server",
        "@org_golang_google_grpc//:go_default_library",
        "@org_golang_google_grpc//reflection",
    ],
)

go_binary(
    name = "service-one",
    embed = [":service-one_lib"],
    goarch = "amd64",
    goos = "linux",
    visibility = ["//visibility:public"],
)

container_image(
    name = "image",
    base = "@go_base//image",
    entrypoint = ["/service-one"],
    files = [
        ":service-one",
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
    repository = "ekhabarov/service-one",
    tag = "$(IMAGE_TAG)",
)
