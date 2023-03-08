load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

http_archive(
    name = "io_bazel_rules_go",
    sha256 = "dd926a88a564a9246713a9c00b35315f54cbd46b31a26d5d8fb264c07045f05d",
    urls = [
        "https://mirror.bazel.build/github.com/bazelbuild/rules_go/releases/download/v0.38.1/rules_go-v0.38.1.zip",
        "https://github.com/bazelbuild/rules_go/releases/download/v0.38.1/rules_go-v0.38.1.zip",
    ],
)

load("@io_bazel_rules_go//go:deps.bzl", "go_register_toolchains", "go_rules_dependencies")

go_rules_dependencies()

go_register_toolchains(version = "1.20.2")

http_archive(
    name = "bazel_gazelle",
    sha256 = "ecba0f04f96b4960a5b250c8e8eeec42281035970aa8852dda73098274d14a1d",
    urls = [
        "https://mirror.bazel.build/github.com/bazelbuild/bazel-gazelle/releases/download/v0.29.0/bazel-gazelle-v0.29.0.tar.gz",
        "https://github.com/bazelbuild/bazel-gazelle/releases/download/v0.29.0/bazel-gazelle-v0.29.0.tar.gz",
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

TILT_VERSION = "0.31.2"

TILT_ARCH = "x86_64"

TILT_URL = "https://github.com/windmilleng/tilt/releases/download/v{VER}/tilt.{VER}.{OS}.{ARCH}.tar.gz"

http_archive(
    name = "tilt_linux_x86_64",
    build_file_content = "exports_files(['tilt'])",
    sha256 = "9ec1a219393367fc41dd5f5f1083f60d6e9839e5821b8170c26481bf6b19dc7e",
    urls = [TILT_URL.format(
        ARCH = TILT_ARCH,
        OS = "linux",
        VER = TILT_VERSION,
    )],
)

http_archive(
    name = "tilt_darwin_x86_64",
    build_file_content = "exports_files(['tilt'])",
    sha256 = "ade0877e72f56a089377e517efc86369220ac7b6a81f078e8e99a9c29aa244eb",
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
    digest = "sha256:bbc5144e2391e4cbbafda1b9d71d04333f3ea783eadaabad6a76aa316fe3df6d",
    registry = "index.docker.io",
    repository = "envoyproxy/envoy",
    tag = "v1.25.2",
)

# https://github.com/GoogleContainerTools/distroless/tree/main/base
container_pull(
    name = "go_base",
    digest = "sha256:2259760686e4955ddb1c5e8e584055754358873eef4faa0eaeeccb5685b1b20b",  #base
    registry = "gcr.io",
    repository = "distroless/base",
    tag = "latest",
)
