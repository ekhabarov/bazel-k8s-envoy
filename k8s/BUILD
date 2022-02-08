load("@io_bazel_rules_k8s//k8s:object.bzl", "k8s_object")
load("//:helpers.bzl", "default_namespace")

package(default_visibility = ["//visibility:public"])

filegroup(
    name = "api-deployment-yaml",
    srcs = [
        "api-deployment.yaml",
    ],
)

filegroup(
    name = "namespace",
    srcs = [
        "namespace.yaml",
    ],
)

k8s_object(
    name = "namespace-yaml",
    kind = "deployment",
    substitutions = default_namespace(),
    template = ":namespace",
)
