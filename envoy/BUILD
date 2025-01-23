load("@rules_oci//oci:defs.bzl", "oci_image", "oci_push", "oci_load")
load("@rules_ytt//:defs.bzl", "ytt")
load("//:stamp.bzl", "stamp")
load("//utils:tar.bzl", "mtar")

package(default_visibility = ["//visibility:public"])

mtar(
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

oci_load(
   name = "tarball",
    image = ":image",
    repo_tags = ["bazel/envoy:latest"],
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
        ":image.digest",
        ":ports.yaml",
        ":values.yaml",
        "//k8s:defaults.yaml",
        "//k8s/base:service.yaml",
    ],
)
