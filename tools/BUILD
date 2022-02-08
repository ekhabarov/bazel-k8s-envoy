sh_binary(
    name = "tilt-up",
    srcs = ["wrapper.sh"],
    args = [
        "tilt",
        "up",
        "--hud=true",
    ],
    data = select({
        "@bazel_tools//src/conditions:darwin": ["@tilt_darwin_x86_64//:tilt"],
        "//conditions:default": ["@tilt_linux_x86_64//:tilt"],
    }),
)

sh_binary(
    name = "tilt-down",
    srcs = ["wrapper.sh"],
    args = [
        "tilt",
        "down",
        "--delete-namespaces",
    ],
    data = select({
        "@bazel_tools//src/conditions:darwin": ["@tilt_darwin_x86_64//:tilt"],
        "//conditions:default": ["@tilt_linux_x86_64//:tilt"],
    }),
)
