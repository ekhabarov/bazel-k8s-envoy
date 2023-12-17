load("@rules_oci//oci:defs.bzl", "oci_image", "oci_push", "oci_tarball")
load("@rules_pkg//:pkg.bzl", "pkg_tar")
load("@rules_ytt//:defs.bzl", "ytt")
load("//:stamp.bzl", "stamp")

package(default_visibility = ["//visibility:public"])

pkg_tar(
    name = "tar",
    srcs = [
        ":envoy.yaml",
        "//service-one/pb:service_one_descriptor_set",
    ],
)

oci_image(
    name = "image",
    base = "@envoy_base",
    tars = [":tar"],
)

oci_tarball(
    name = "tarball",
    image = ":image",
    repo_tags = ["envoy:latest"],
)

stamp(
    name = "stamped",
)

oci_push(
    name = "push_image",
    image = ":image",
    remote_tags = ["latest"],
    repository = "ghcr.io/ekhabarov/envoy",
)

ytt(
    name = "yaml",
    srcs = [
        ":command.yaml",
        ":ports.yaml",
        ":values.yaml",
        "//k8s:defaults.yaml",
        "//k8s/base:service.yaml",
        ":image.digest",
    ],
)
