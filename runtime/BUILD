load("@io_bazel_rules_go//go:def.bzl", "go_binary", "go_library")
load("@rules_oci//oci:defs.bzl", "oci_image", "oci_push", "oci_load")
load("//:stamp.bzl", "stamp")
load("//utils:tar.bzl", "mtar")

go_library(
    name = "runtime_lib",
    srcs = ["main.go"],
    importpath = "github.com/ekhabarov/bazel-k8s-envoy/runtime",
    visibility = ["//visibility:private"],
)

go_binary(
    name = "runtime",
    embed = [":runtime_lib"],
    visibility = ["//visibility:public"],
)

mtar(
    name = "tar",
    srcs = [":runtime"],
)

oci_image(
    name = "image",
    base = "@distroless_base",
    entrypoint = ["/runtime"],
    tars = [":tar"],
)

oci_load(
    name = "tarball",
    image = ":image",
    repo_tags = ["runtime:latest"],
)

stamp(
    name = "stamped",
)

oci_push(
    name = "image_push",
    image = ":image",
    remote_tags = ":stamped",
    repository = "ghcr.io/ekhabarov/runtime",
)
