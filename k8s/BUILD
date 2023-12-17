load("@rules_ytt//:defs.bzl", "ytt")

exports_files([
    "defaults.yaml",
])

ytt(
  name = "ns",
  srcs = [
    ":defaults.yaml",
    ":values.yaml",
    "//k8s/base:namespace.yaml",
  ]
)
