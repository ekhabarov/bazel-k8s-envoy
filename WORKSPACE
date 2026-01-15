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

TILT_VERSION = "0.36.0"

TILT_URL = "https://github.com/windmilleng/tilt/releases/download/v{VER}/tilt.{VER}.{OS}.{ARCH}.tar.gz"

_tilt_sha = {
    "linux_arm64": "1fb79ec7609c9d430c29c66d9d1c12c2a58aaf2314bf42d7372105f8ab2eb4ce",
    "linux_x86_64": "9ce610083efc76ffa518ec9b001ddb1711b652adce3333f57ffff6be50ad9719",
    "mac_arm64": "2e7c99c07d9a06ba8b76bc758c8808f263e12356ea88bba7438f61832e9963df",
    "mac_x86_64": "07639c3ec1a22301ce2b4b96f9786074a53ae56714c2fb1940611d60a04d7bc9",
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
