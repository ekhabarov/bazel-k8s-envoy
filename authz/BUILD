load("@io_bazel_rules_go//go:def.bzl", "go_binary", "go_library")
load("@rules_ytt//:defs.bzl", "ytt")
load("@rules_pkg//:pkg.bzl", "pkg_tar")
load("@rules_oci//oci:defs.bzl", "oci_image", "oci_image_index", "oci_push", "oci_tarball")
load("//:stamp.bzl", "stamp")
load("//:platforms.bzl", "ARCH", "OS")

go_library(
    name = "authz_lib",
    srcs = ["main.go"],
    importpath = "github.com/ekhabarov/bazel-k8s-envoy/authz",
    visibility = ["//visibility:private"],
    deps = [
        "//authz/server",
        "@com_github_envoyproxy_go_control_plane//envoy/service/auth/v3:auth",
        "@org_golang_google_grpc//:go_default_library",
        "@org_golang_google_grpc//reflection",
    ],
)

[[
    go_binary(
        name = "authz_{os}_{arch}".format(
            arch = arch,
            os = os,
        ),
        embed = [":authz_lib"],
        goarch = arch,
        goos = os,
        visibility = ["//visibility:public"],
    ),
    pkg_tar(
        name = "tar_{os}_{arch}".format(
            arch = arch,
            os = os,
        ),
        srcs = [":authz_{os}_{arch}".format(
            arch = arch,
            os = os,
        )],
    ),
    oci_image(
        name = "image_{os}_{arch}".format(
            arch = arch,
            os = os,
        ),
        base = "@distroless_base",
        entrypoint = ["/authz_{os}_{arch}".format(
            arch = arch,
            os = os,
        )],
        tars = [":tar_{os}_{arch}".format(
            arch = arch,
            os = os,
        )],
    ),
] for arch in ARCH for os in OS]

oci_image_index(
    name = "image",
    images = [
        ":image_linux_arm64",
        ":image_linux_amd64",
    ],
)

oci_tarball(
    name = "tarball",
    image = select({
        "@platforms//cpu:arm64": ":image_linux_arm64",
        "@platforms//cpu:x86_64": ":image_linux_amd64",
    }),
    repo_tags = ["bazel/authz:latest"],
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
    ],
)

go_binary(
    name = "authz",
    embed = [":authz_lib"],
    visibility = ["//visibility:public"],
)
