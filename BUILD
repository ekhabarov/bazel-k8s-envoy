load("@bazel_gazelle//:def.bzl", "gazelle")

# gazelle:prefix github.com/ekhabarov/bazel-k8s-envoy
# gazelle:build_file_name BUILD,BUILD.bazel
gazelle(name = "gazelle")

gazelle(
    name = "deps",
    args = [
        "-from_file=go.mod",
        "-build_file_proto_mode=disable",
        "-to_macro=go_deps.bzl%go_deps",
        "-prune",
    ],
    command = "update-repos",
)
