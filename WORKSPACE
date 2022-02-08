load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

http_archive(
    name = "io_bazel_rules_go",
    sha256 = "8e968b5fcea1d2d64071872b12737bbb5514524ee5f0a4f54f5920266c261acb",
    urls = [
        "https://mirror.bazel.build/github.com/bazelbuild/rules_go/releases/download/v0.28.0/rules_go-v0.28.0.zip",
        "https://github.com/bazelbuild/rules_go/releases/download/v0.28.0/rules_go-v0.28.0.zip",
    ],
)

load("@io_bazel_rules_go//go:deps.bzl", "go_register_toolchains", "go_rules_dependencies")

go_rules_dependencies()

go_register_toolchains(version = "1.17.1")

http_archive(
    name = "bazel_gazelle",
    sha256 = "222e49f034ca7a1d1231422cdb67066b885819885c356673cb1f72f748a3c9d4",
    urls = [
        "https://mirror.bazel.build/github.com/bazelbuild/bazel-gazelle/releases/download/v0.22.3/bazel-gazelle-v0.22.3.tar.gz",
        "https://github.com/bazelbuild/bazel-gazelle/releases/download/v0.22.3/bazel-gazelle-v0.22.3.tar.gz",
    ],
)

load("@bazel_gazelle//:deps.bzl", "gazelle_dependencies")

gazelle_dependencies()

# Protobuf

RULES_PROTO_COMMIT = "f7a30f6f80006b591fa7c437fe5a951eb10bcbcf"

http_archive(
    name = "rules_proto",
    sha256 = "9fc210a34f0f9e7cc31598d109b5d069ef44911a82f507d5a88716db171615a8",
    strip_prefix = "rules_proto-{COMMIT}".format(COMMIT = RULES_PROTO_COMMIT),
    urls = [
        # "https://mirror.bazel.build/github.com/bazelbuild/rules_proto/archive/{COMMIT}.tar.gz".format(COMMIT=RULES_PROTO_COMMIT),
        "https://github.com/bazelbuild/rules_proto/archive/{COMMIT}.tar.gz".format(COMMIT = RULES_PROTO_COMMIT),
    ],
)

load("@rules_proto//proto:repositories.bzl", "rules_proto_dependencies", "rules_proto_toolchains")

rules_proto_dependencies()

rules_proto_toolchains()

http_archive(
    name = "com_google_protobuf",
    sha256 = "1c11b325e9fbb655895e8fe9843479337d50dd0be56a41737cbb9aede5e9ffa0",
    strip_prefix = "protobuf-3.15.3",
    urls = ["https://github.com/protocolbuffers/protobuf/archive/v3.15.3.zip"],
)

load("@com_google_protobuf//:protobuf_deps.bzl", "protobuf_deps")

protobuf_deps()

############## TILT

TILT_VERSION = "0.22.9"

TILT_ARCH = "x86_64"

TILT_URL = "https://github.com/windmilleng/tilt/releases/download/v{VER}/tilt.{VER}.{OS}.{ARCH}.tar.gz"

http_archive(
    name = "tilt_linux_x86_64",
    build_file_content = "exports_files(['tilt'])",
    sha256 = "5ede1bd6bfdf7ad46984166f7d651696616ec2c7b3c7a3fed2a0b9cc8e3d6d6e",
    urls = [TILT_URL.format(
        VER = TILT_VERSION,
        OS = "linux",
        ARCH = TILT_ARCH,
    )],
)

http_archive(
    name = "tilt_darwin_x86_64",
    build_file_content = "exports_files(['tilt'])",
    sha256 = "77a3848233e07e715d1f2f73d7ef10c8164c7457f7a6c8a2dc1d68808bd29fdd",
    urls = [TILT_URL.format(
        VER = TILT_VERSION,
        OS = "mac",
        ARCH = TILT_ARCH,
    )],
)

# Docker rules
http_archive(
    name = "io_bazel_rules_docker",
    sha256 = "59d5b42ac315e7eadffa944e86e90c2990110a1c8075f1cd145f487e999d22b3",
    strip_prefix = "rules_docker-0.17.0",
    urls = ["https://github.com/bazelbuild/rules_docker/releases/download/v0.17.0/rules_docker-v0.17.0.tar.gz"],
)

# go_image
load("@io_bazel_rules_docker//go:image.bzl", _go_image_repos = "repositories")

_go_image_repos()

# Base images
load("@io_bazel_rules_docker//container:pull.bzl", "container_pull")

container_pull(
    name = "envoy_linux_amd64",
    digest = "sha256:e02931a6470916fd1f468d807cded3840062f2effa586ab90b901d7f494cc91f",
    registry = "index.docker.io",
    repository = "envoyproxy/envoy",
    tag = "v1.17.1",
)

container_pull(
    name = "go_base",
    digest = "sha256:1d40fb1b82f00135635dd5864ec91a70dff306a1c81cb6761c0982144cd5351f",  #base
    registry = "gcr.io",
    repository = "distroless/base",
)

load("//:go_deps.bzl", "go_deps")

# gazelle:repository_macro go_deps.bzl%go_deps
go_deps()

load("//:go_deps_patched.bzl", "go_deps_patched")

go_deps_patched()

# Kubernetes
http_archive(
    name = "io_bazel_rules_k8s",
    sha256 = "51f0977294699cd547e139ceff2396c32588575588678d2054da167691a227ef",
    strip_prefix = "rules_k8s-0.6",
    urls = ["https://github.com/bazelbuild/rules_k8s/archive/v0.6.tar.gz"],
)

load("@io_bazel_rules_k8s//k8s:k8s.bzl", "k8s_repositories")

k8s_repositories()

load("@io_bazel_rules_k8s//k8s:k8s_go_deps.bzl", k8s_go_deps = "deps")

k8s_go_deps()  # toolchain
