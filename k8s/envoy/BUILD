load("@io_bazel_rules_docker//container:container.bzl", "container_image")
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
    stamp = True,
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
