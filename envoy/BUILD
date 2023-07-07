load("@io_bazel_rules_docker//container:container.bzl", "container_image", "container_push")
load("@com_github_ebay_rules_ytt//:def.bzl", "ytt")

package(default_visibility = ["//visibility:public"])

container_image(
    name = "image",
    base = "@envoy_linux_amd64//image",
    files = [
        ":envoy.yaml",
        "//service-one/pb:service_one_descriptor_set",
    ],
    ports = [
        "8080/tcp",
        "8081/tcp",
    ],
)

ytt(
    name = "yaml",
    srcs = [
        "//k8s:defaults.yaml",
        "//k8s/base:service.yaml",
        ":command.yaml",
        ":ports.yaml",
        ":values.yaml",
    ],
    image = ":image.digest",
)

container_push(
    name = "push_image",
    format = "Docker",
    image = ":image",
    registry = "ghcr.io",
    repository = "ekhabarov/envoy",
    tag = "$(IMAGE_TAG)",
)
