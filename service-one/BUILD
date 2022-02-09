load("@io_bazel_rules_go//go:def.bzl", "go_binary", "go_library")
load("@io_bazel_rules_docker//go:image.bzl", "go_image")
load("@io_bazel_rules_docker//container:container.bzl", "container_image", "container_push")
load("@io_bazel_rules_k8s//k8s:object.bzl", "k8s_object")
load("//:helpers.bzl", "namespace")

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
    visibility = ["//visibility:public"],
)

go_image(
    name = "image",
    embed = ["service-one_lib"],
    importpath = "github.com/ekhabarov/bazel-k8s-envoy/service-one",
)

container_image(
    name = "custom_image",
    base = "@go_base//image",
    entrypoint = ["/service-one"],
    env = {
        "ENV_VAR1": "value1",
        "ENV_VAR2": "value2",
    },
    files = [
        ":service-one",
    ],
    labels = {
        "version": "1.0.0",
    },
    ports = [
        "5001/tcp",
    ],
)

k8s_object(
    name = "yaml",
    kind = "deployment",
    substitutions = {
        "%{apiname}": "service-one",
        "%{namespace}": namespace(),
    },
    template = "//k8s:api-deployment-yaml",
)

container_push(
    name = "push_image",
    format = "Docker",
    image = ":image",
    registry = "ghcr.io",
    repository = "ekhabarov/service-one",
    tag = "$(IMAGE_TAG)",
)
