load("@io_bazel_rules_go//go:def.bzl", "go_binary", "go_library")
load("@io_bazel_rules_docker//container:container.bzl", "container_image", "container_push")
load("@com_github_ebay_rules_ytt//:def.bzl", "ytt")
load("@rules_pkg//:pkg.bzl", "pkg_tar")
load("@rules_oci//oci:defs.bzl", "oci_image", "oci_push", "oci_tarball")
load("//:stamp.bzl", "stamp")

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

pkg_tar(
    name = "tar",
    srcs = [":service-one"],
)

oci_image(
    name = "image",
    base = "@distroless_base",
    entrypoint = ["/service-one"],
    tars = [":tar"],
)

oci_tarball(
    name = "tarball",
    image = ":image",
    repo_tags = ["service-one:latest"],
)

stamp(
    name = "stamped",
)

oci_push(
    name = "push_image",
    image = ":image",
    remote_tags = ":stamped",
    repository = "ghcr.io/ekhabarov/service-one",
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
