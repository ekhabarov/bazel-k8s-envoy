load("@aspect_bazel_lib//lib:tar.bzl", "tar")

def mtar(name, srcs, strip_prefix="", **kwargs):
    cmd = "\n".join([
            "echo {file} uid=0 gid=0 time=1672560000 mode=0755 type=file content=$(location {src}) >> $@".format(
         file = native.package_relative_label(f).name,
         src = native.package_relative_label(f)
            ) for f in srcs
        ])

    native.genrule(
        name = name + "_mtree",
        outs = [name + "_m.spec"],
        srcs = [native.package_relative_label(s) for s in srcs],
        cmd = cmd,
    )
    tar(
        name = name,
        srcs = srcs,
        mtree = name + "_mtree",
        **kwargs,
    )
