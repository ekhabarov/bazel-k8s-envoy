load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

http_archive(
    name = "com_github_sluongng_nogo_analyzer",
    sha256 = "0dc6b5e86094d081e05bcd0c3e41fc275a2398c64e545376166139412181f150",
    strip_prefix = "nogo-analyzer-0.0.3",
    urls = [
        "https://github.com/sluongng/nogo-analyzer/archive/refs/tags/v0.0.3.tar.gz",
    ],
)

load("@com_github_sluongng_nogo_analyzer//staticcheck:deps.bzl", "staticcheck")

staticcheck()

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
