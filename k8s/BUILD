exports_files([
    "defaults.yaml",
])

genrule(
    name = "ns",
    srcs = [
        ":defaults.yaml",
        ":values.yaml",
        "//k8s/base:namespace.yaml",
    ],
    outs = ["manifest.yaml"],
    cmd = """
      echo $(location @com_github_vmware_tanzu_carvel_ytt//cmd/ytt) \
         `ls $(SRCS) | sed 's/^/-f /g'` \
          > $@
    """,
    executable = True,
    tools = [
        "@com_github_vmware_tanzu_carvel_ytt//cmd/ytt",
    ],
    visibility = ["//visibility:public"],
)
