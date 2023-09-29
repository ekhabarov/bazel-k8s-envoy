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

TILT_VERSION = "0.33.1"

TILT_ARCH = "x86_64"

TILT_URL = "https://github.com/windmilleng/tilt/releases/download/v{VER}/tilt.{VER}.{OS}.{ARCH}.tar.gz"

http_archive(
    name = "tilt_linux_x86_64",
    build_file_content = "exports_files(['tilt'])",
    sha256 = "34ea609c7933084781cdd88a20b5e8b42c41d164460ba59cb8ea612ed106847d",
    urls = [TILT_URL.format(
        ARCH = TILT_ARCH,
        OS = "linux",
        VER = TILT_VERSION,
    )],
)

http_archive(
    name = "tilt_darwin_x86_64",
    build_file_content = "exports_files(['tilt'])",
    sha256 = "b5ef9875ef4027ce8e750ccac86eb0e768e5e7c15647e02a1641466f2b501a0e",
    urls = [TILT_URL.format(
        ARCH = TILT_ARCH,
        OS = "mac",
        VER = TILT_VERSION,
    )],
)

### OCI ###
http_archive(
    name = "rules_oci",
    sha256 = "21a7d14f6ddfcb8ca7c5fc9ffa667c937ce4622c7d2b3e17aea1ffbc90c96bed",
    strip_prefix = "rules_oci-1.4.0",
    url = "https://github.com/bazel-contrib/rules_oci/releases/download/v1.4.0/rules_oci-v1.4.0.tar.gz",
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
    digest = "sha256:ccaef5ee2f1850270d453fdf700a5392534f8d1a8ca2acda391fbb6a06b81c86",  #multi-arch
    image = "gcr.io/distroless/base",
    platforms = [
        "linux/amd64",
        "linux/arm64",
    ],
)

oci_pull(
    name = "envoy_base",
    # tag = "distroless-v1.27.0",
    digest = "sha256:e315dd6b713bc6fc98d782940046d4a55711117f61d318459121c0bdfaac70ef",
    image = "index.docker.io/envoyproxy/envoy",
    platforms = [
        "linux/amd64",
        "linux/arm64",
    ],
)

### PKG
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

###########

### Aspect rules
http_archive(
    name = "aspect_bazel_lib",
    sha256 = "09b51a9957adc56c905a2c980d6eb06f04beb1d85c665b467f659871403cf423",
    strip_prefix = "bazel-lib-1.34.5",
    url = "https://github.com/aspect-build/bazel-lib/releases/download/v1.34.5/bazel-lib-v1.34.5.tar.gz",
)

load("@aspect_bazel_lib//lib:repositories.bzl", "aspect_bazel_lib_dependencies")

aspect_bazel_lib_dependencies()

###########

http_archive(
    name = "com_github_ebay_rules_ytt",
    sha256 = "0232522fd7a07d2eb0a47fe4ec3a6dc8bc8e0bcbaa8abd658c6be53a34f5bd76",
    strip_prefix = "rules_ytt-0.1.0",
    urls = [
        "https://github.com/eBay/rules_ytt/releases/download/v0.1.0/rules_ytt-0.1.0.zip",
    ],
)

load("@com_github_ebay_rules_ytt//:deps.bzl", "ytt_rules_dependencies")

ytt_rules_dependencies()
