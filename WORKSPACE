load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

http_archive(
    name = "com_github_sluongng_nogo_analyzer",
    sha256 = "0dc6b5e86094d081e05bcd0c3e41fc275a2398c64e545376166139412181f150",
    strip_prefix = "nogo-analyzer-0.0.3",
    urls = [
        "https://github.com/sluongng/nogo-analyzer/archive/refs/tags/v0.0.3.tar.gz",
    ],
)

http_archive(
    name = "io_bazel_rules_go",
    sha256 = "f4a9314518ca6acfa16cc4ab43b0b8ce1e4ea64b81c38d8a3772883f153346b8",
    urls = [
        "https://mirror.bazel.build/github.com/bazelbuild/rules_go/releases/download/v0.50.1/rules_go-v0.50.1.zip",
        "https://github.com/bazelbuild/rules_go/releases/download/v0.50.1/rules_go-v0.50.1.zip",
    ],
)

http_archive(
    name = "googleapis",
    sha256 = "12b19423a8cf8d35848440e818d5c5385848edf59d3da434e6ea49a070482526",
    strip_prefix = "googleapis-d6f184876ec67295addccbb70aa4af622e049a7e",
    urls = [
        "https://github.com/googleapis/googleapis/archive/d6f184876ec67295addccbb70aa4af622e049a7e.zip",
    ],
)

load("@googleapis//:repository_rules.bzl", "switched_rules_by_language")

switched_rules_by_language(
    name = "com_google_googleapis_imports",
    go = True,
)


load("@io_bazel_rules_go//go:deps.bzl", "go_register_toolchains", "go_rules_dependencies")

go_rules_dependencies()

go_register_toolchains(
    nogo = "@//:nogo",
    version = "1.22.7",
)

http_archive(
    name = "bazel_gazelle",
    integrity = "sha256-LHVFzJFKQR5cFcPVWgpe00+/9i3vDh8Ktu0UvaIiw8w=",
    urls = [
        "https://mirror.bazel.build/github.com/bazelbuild/bazel-gazelle/releases/download/v0.39.0/bazel-gazelle-v0.39.0.tar.gz",
        "https://github.com/bazelbuild/bazel-gazelle/releases/download/v0.39.0/bazel-gazelle-v0.39.0.tar.gz",
    ],
)

load("@bazel_gazelle//:deps.bzl", "gazelle_dependencies")
load("//:go_deps.bzl", "go_deps")

# gazelle:repository_macro go_deps.bzl%go_deps
go_deps()

load("@com_github_sluongng_nogo_analyzer//staticcheck:deps.bzl", "staticcheck")

staticcheck()

gazelle_dependencies()

http_archive(
    name = "rules_proto",
    sha256 = "6fb6767d1bef535310547e03247f7518b03487740c11b6c6adb7952033fe1295",
    strip_prefix = "rules_proto-6.0.2",
    url = "https://github.com/bazelbuild/rules_proto/releases/download/6.0.2/rules_proto-6.0.2.tar.gz",
)

load("@rules_proto//proto:repositories.bzl", "rules_proto_dependencies")

rules_proto_dependencies()

load("@rules_proto//proto:setup.bzl", "rules_proto_setup")

rules_proto_setup()

load("@rules_proto//proto:toolchains.bzl", "rules_proto_toolchains")

rules_proto_toolchains()


############## TILT

TILT_VERSION = "0.33.12"

TILT_URL = "https://github.com/windmilleng/tilt/releases/download/v{VER}/tilt.{VER}.{OS}.{ARCH}.tar.gz"

_tilt_sha = {
    "linux_arm64": "584bb4a288bf19666356a26e178b6c9ec0e9cd18863e38eca64ff96bb33019ef",
    "linux_x86_64": "a8ba6f489d4b0145c7c4447195b0ee7de191bffeebd61c2887d34fe3dc173ac1",
    "mac_arm64": "29c916a79ef3c83bbd5525d8b000d1bb2aa738523ad7dd2c65f9f09f4abbe83e",
    "mac_x86_64": "f7db4f1318be278f7b6c1efff5d2483642a6eb3f2fa86f6e99757664703b2fdb",
}

[http_archive(
    name = "tilt_{os}_{arch}".format(
        arch = arch,
        os = os if os == "linux" else "darwin",
    ),
    build_file_content = "exports_files(['tilt'])",
    sha256 = _tilt_sha["%s_%s" % (os, arch)],
    urls = [TILT_URL.format(
        ARCH = arch,
        OS = os,
        VER = TILT_VERSION,
    )],
) for arch in [
    "x86_64",
    "arm64",
] for os in [
    "linux",
    "mac",
]]

http_archive(
    name = "aspect_bazel_lib",
    sha256 = "87ab4ec479ebeb00d286266aca2068caeef1bb0b1765e8f71c7b6cfee6af4226",
    strip_prefix = "bazel-lib-2.7.3",
    url = "https://github.com/aspect-build/bazel-lib/releases/download/v2.7.3/bazel-lib-v2.7.3.tar.gz",
)

load("@aspect_bazel_lib//lib:repositories.bzl", "aspect_bazel_lib_dependencies", "aspect_bazel_lib_register_toolchains")

# Required bazel-lib dependencies

aspect_bazel_lib_dependencies()

# Register bazel-lib toolchains

aspect_bazel_lib_register_toolchains()

http_archive(
    name = "com_google_protobuf",
    sha256 = "3cf7d5b17c4ff04fe9f038104e9d0cae6da09b8ce271c13e44f8ac69f51e4e0f",
    strip_prefix = "protobuf-25.5",
    urls = ["https://github.com/protocolbuffers/protobuf/releases/download/v25.5/protobuf-25.5.tar.gz"],
)

load("@com_google_protobuf//:protobuf_deps.bzl", "protobuf_deps")

protobuf_deps()

### OCI ###
http_archive(
    name = "rules_oci",
    sha256 = "56d5499025d67a6b86b2e6ebae5232c72104ae682b5a21287770bd3bf0661abf",
    strip_prefix = "rules_oci-1.7.5",
    url = "https://github.com/bazel-contrib/rules_oci/releases/download/v1.7.5/rules_oci-v1.7.5.tar.gz",
)

load("@rules_oci//oci:dependencies.bzl", "rules_oci_dependencies")

rules_oci_dependencies()

load("@rules_oci//oci:repositories.bzl", "LATEST_CRANE_VERSION", "LATEST_ZOT_VERSION", "oci_register_toolchains")

oci_register_toolchains(
    name = "oci",
    crane_version = LATEST_CRANE_VERSION,
)

load("@rules_oci//oci:pull.bzl", "oci_pull")

oci_pull(
    name = "distroless_base",
    digest = "sha256:280852156756ea3f39f9e774a30346f2e756244e1f432aea3061c4ac85d90a66",  #multi-arch
    image = "gcr.io/distroless/base",
    platforms = [
        "linux/amd64",
        "linux/arm64/v8",
    ],
)

oci_pull(
    name = "envoy_base",
    # tag = "distroless-v1.28.0",
    digest = "sha256:0bb664e36cef65b884965b22bbb2fbd1acecb8bb174683a321677c4fc7475593",
    image = "index.docker.io/envoyproxy/envoy",
    platforms = [
        "linux/amd64",
        "linux/arm64",
    ],
)

http_archive(
    name = "rules_ytt",
    sha256 = "876ab0223567ec7556107374a9b9cb3e3db9ba5bb97e778c35d36f1d1f717879",
    strip_prefix = "rules_ytt-0.2.0",
    url = "https://github.com/ekhabarov/rules_ytt/releases/download/v0.2.0/rules_ytt-v0.2.0.tar.gz",
)

load("@rules_ytt//ytt:repositories.bzl", "rules_ytt_dependencies", "rules_ytt_register_toolchains")

rules_ytt_dependencies()

rules_ytt_register_toolchains()
