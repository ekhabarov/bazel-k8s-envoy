load("@io_bazel_rules_docker//container:container.bzl", "container_image", "container_push")
load("@io_bazel_rules_k8s//k8s:object.bzl", "k8s_object")
load("@io_bazel_rules_k8s//k8s:objects.bzl", "k8s_objects")
load("//:helpers.bzl", "default_namespace")

package(default_visibility = ["//visibility:public"])

container_image(
    name = "image",
    base = "@envoy_linux_amd64//image",
    files = [
        "//service-one/pb:service_one_descriptor_set",
    ],
    stamp = "@io_bazel_rules_docker//stamp:use_stamp_flag",
    workdir = "/etc/envoy",
)

filegroup(
    name = "config-map",
    srcs = [
        "config-map.yaml",
    ],
)

k8s_object(
    name = "config-map-yaml",
    kind = "configMap",
    substitutions = default_namespace(),
    template = ":config-map",
)

filegroup(
    name = "deployment",
    srcs = [
        "deployment.yaml",
    ],
)

k8s_object(
    name = "deployment-yaml",
    kind = "deployment",
    substitutions = default_namespace(),
    template = ":deployment",
)

container_push(
    name = "push_image",
    format = "Docker",
    image = ":image",
    registry = "ghcr.io",
    repository = "ekhabarov/envoy",
    tag = "$(IMAGE_TAG)",
)
