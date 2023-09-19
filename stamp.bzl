# Use with --stamp --embed_label=v0.0.1
def stamp(name):
  native.genrule(
    name = name,
    outs = ["stamped.txt"],
    cmd = "grep BUILD_EMBED_LABEL bazel-out/stable-status.txt | cut -d ' ' -f 2 >$@",
    stamp = True,
  )
