load("@io_bazel_rules_go//go:def.bzl", "go_binary", "go_library")
load("@rules_ytt//:defs.bzl", "ytt")
load("@rules_pkg//:pkg.bzl", "pkg_tar")
load("@rules_oci//oci:defs.bzl", "oci_image", "oci_push", "oci_tarball")
load("//:stamp.bzl", "stamp")

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

pkg_tar(
    name = "tar",
    srcs = [":authz"],
)

oci_image(
    name = "image",
    base = "@distroless_base",
    entrypoint = ["/authz"],
    tars = [":tar"],
)

oci_tarball(
    name = "tarball",
    image = ":image",
    repo_tags = ["authz:latest"],
)

stamp(
    name = "stamped",
)

oci_push(
    name = "push_image",
    image = ":image",
    remote_tags = ":stamped",
    repository = "ghcr.io/ekhabarov/authz",
)

ytt(
    name = "yaml",
    srcs = [
        ":values.yaml",
        "//k8s:defaults.yaml",
        "//k8s/base:service.yaml",
        ":image.digest",
    ],
)
