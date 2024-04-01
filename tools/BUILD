_data = select({
    "@bazel_tools//src/conditions:darwin_arm64": ["@tilt_darwin_arm64//:tilt"],
    "@bazel_tools//src/conditions:darwin_x86_64": ["@tilt_darwin_x86_64//:tilt"],
    "@bazel_tools//src/conditions:linux_aarch64": ["@tilt_linux_arm64//:tilt"],
    "@bazel_tools//src/conditions:linux_x86_64": ["@tilt_linux_x86_64//:tilt"],
})

sh_binary(
    name = "tilt-up",
    srcs = ["wrapper.sh"],
    args = [
        "tilt",
        "up",
        "--legacy=true",
    ],
    data = _data,
)

sh_binary(
    name = "tilt-down",
    srcs = ["wrapper.sh"],
    args = [
        "tilt",
        "down",
        "--delete-namespaces",
    ],
    data = _data,
)
