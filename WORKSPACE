load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

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

go_register_toolchains(version = "1.20.5")

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

http_archive(
    name = "io_bazel_rules_docker",
    sha256 = "b1e80761a8a8243d03ebca8845e9cc1ba6c82ce7c5179ce2b295cd36f7e394bf",
    urls = ["https://github.com/bazelbuild/rules_docker/releases/download/v0.25.0/rules_docker-v0.25.0.tar.gz"],
)

load("@io_bazel_rules_docker//repositories:repositories.bzl", container_repositories = "repositories")

container_repositories()

load("@io_bazel_rules_docker//repositories:deps.bzl", container_deps = "deps")

container_deps()

# go_image
load("@io_bazel_rules_docker//go:image.bzl", _go_image_repos = "repositories")

_go_image_repos()

# Base images
load("@io_bazel_rules_docker//container:pull.bzl", "container_pull")

container_pull(
    name = "envoy_linux_amd64",
    digest = "sha256:ae3a208980bda7c2635dfb9637ae6994b27c4d1c8dc5b41b6ecba8434fda380d",
    registry = "index.docker.io",
    repository = "envoyproxy/envoy",
    tag = "distroless-v1.26.2",
)

# https://github.com/GoogleContainerTools/distroless/tree/main/base
container_pull(
    name = "go_base",
    digest = "sha256:2259760686e4955ddb1c5e8e584055754358873eef4faa0eaeeccb5685b1b20b",  #base
    registry = "gcr.io",
    repository = "distroless/base",
    tag = "latest",
)

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
