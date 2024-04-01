load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

http_archive(
    name = "com_github_sluongng_nogo_analyzer",
    sha256 = "a74a5e44751d292d17bd879e5aa8b40baa94b5dc2f043df1e3acbb3e23ead073",
    strip_prefix = "nogo-analyzer-0.0.2",
    urls = [
        "https://github.com/sluongng/nogo-analyzer/archive/refs/tags/v0.0.2.tar.gz",
    ],
)

http_archive(
    name = "io_bazel_rules_go",
    sha256 = "51dc53293afe317d2696d4d6433a4c33feedb7748a9e352072e2ec3c0dafd2c6",
    urls = [
        "https://mirror.bazel.build/github.com/bazelbuild/rules_go/releases/download/v0.40.1/rules_go-v0.40.1.zip",
        "https://github.com/bazelbuild/rules_go/releases/download/v0.40.1/rules_go-v0.40.1.zip",
    ],
)

load("@io_bazel_rules_go//go:deps.bzl", "go_register_toolchains", "go_rules_dependencies")

go_rules_dependencies()

go_register_toolchains(
    nogo = "@//:nogo",
    version = "1.20.8",
)

http_archive(
    name = "bazel_gazelle",
    sha256 = "b8b6d75de6e4bf7c41b7737b183523085f56283f6db929b86c5e7e1f09cf59c9",
    urls = [
        "https://mirror.bazel.build/github.com/bazelbuild/bazel-gazelle/releases/download/v0.31.1/bazel-gazelle-v0.31.1.tar.gz",
        "https://github.com/bazelbuild/bazel-gazelle/releases/download/v0.31.1/bazel-gazelle-v0.31.1.tar.gz",
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
    sha256 = "dc3fb206a2cb3441b485eb1e423165b231235a1ea9b031b4433cf7bc1fa460dd",
    strip_prefix = "rules_proto-5.3.0-21.7",
    urls = [
        "https://github.com/bazelbuild/rules_proto/archive/refs/tags/5.3.0-21.7.tar.gz",
    ],
)

load("@rules_proto//proto:repositories.bzl", "rules_proto_dependencies", "rules_proto_toolchains")

rules_proto_dependencies()

rules_proto_toolchains()

http_archive(
    name = "com_google_protobuf",
    sha256 = "04e1ed9664d1325b43723b6a62a4a41bf6b2b90ac72b5daee288365aad0ea47d",
    strip_prefix = "protobuf-3.20.3",
    urls = ["https://github.com/protocolbuffers/protobuf/archive/v3.20.3.zip"],
)

load("@com_google_protobuf//:protobuf_deps.bzl", "protobuf_deps")

# protobuf_deps()

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

### PKG
# TODO(ekhabarov): replace with bazel-lib/tar
http_archive(
    name = "rules_pkg",
    sha256 = "8f9ee2dc10c1ae514ee599a8b42ed99fa262b757058f65ad3c384289ff70c4b8",
    urls = [
        "https://mirror.bazel.build/github.com/bazelbuild/rules_pkg/releases/download/0.9.1/rules_pkg-0.9.1.tar.gz",
        "https://github.com/bazelbuild/rules_pkg/releases/download/0.9.1/rules_pkg-0.9.1.tar.gz",
    ],
)

load("@rules_pkg//:deps.bzl", "rules_pkg_dependencies")

rules_pkg_dependencies()

http_archive(
    name = "rules_ytt",
    sha256 = "876ab0223567ec7556107374a9b9cb3e3db9ba5bb97e778c35d36f1d1f717879",
    strip_prefix = "rules_ytt-0.2.0",
    url = "https://github.com/ekhabarov/rules_ytt/releases/download/v0.2.0/rules_ytt-v0.2.0.tar.gz",
)

load("@rules_ytt//ytt:repositories.bzl", "rules_ytt_dependencies", "rules_ytt_register_toolchains")

rules_ytt_dependencies()

rules_ytt_register_toolchains()
