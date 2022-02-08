load("@bazel_gazelle//:deps.bzl", "go_repository")

def go_deps_patched():
  go_repository(
      name = "com_github_envoyproxy_protoc_gen_validate",
      build_file_proto_mode = "disable_global",
      importpath = "github.com/envoyproxy/protoc-gen-validate",
      patches = ["//tools/patches/envoy:com_github_envoyproxy_protoc_gen_validate_validate_BUILD.patch"],
      sum = "h1:EQciDnbrYxy13PgWoY8AqoxGiPrpgBZ1R8UNe3ddc+A=",
      version = "v0.1.0",
  )

