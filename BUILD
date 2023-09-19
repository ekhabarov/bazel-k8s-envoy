load("@bazel_gazelle//:def.bzl", "gazelle")
load("@com_github_sluongng_nogo_analyzer//staticcheck:def.bzl", "staticcheck_analyzers")
load("@com_github_sluongng_nogo_analyzer//:def.bzl", "nogo_config")
load("@io_bazel_rules_go//go:def.bzl", "TOOLS_NOGO", "nogo")

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

load(":staticheck.bzl", "STATICHECK_ANALYZERS", "STATICHECK_OVERRIDE")

nogo_config(
    name = "nogo_config",
    out = "nogo_config.json",
    analyzers = STATICHECK_ANALYZERS,
    override = STATICHECK_OVERRIDE,
)

nogo(
    name = "nogo",
    config = ":nogo_config.json",
    visibility = ["//visibility:public"],
    deps = staticcheck_analyzers(STATICHECK_ANALYZERS),
)
