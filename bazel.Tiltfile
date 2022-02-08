arch = "amd64"

if k8s_context().endswith("@pi"):
  arch = "arm"

BAZEL_RUN_CMD = "bazel run --platforms=@io_bazel_rules_go//go/toolchain:linux_{arch} %s -- --norun".format(arch=arch)

# build dependencies: what dependencies does Bazel need to execute this target?
BAZEL_SOURCES_CMD = """
  bazel query 'filter("^//", kind("source file", deps(set(%s))))' --order_output=no
  """.strip()

# source dependencies: What are the target's dependencies?
BAZEL_BUILDFILES_CMD = """
  bazel query 'filter("^//", buildfiles(deps(set(%s))))' --order_output=no
  """.strip()

def watch_labels(labels):
  watched_files = []
  for l in labels:
    if l.startswith("@"):
      continue
    elif l.startswith("//external/") or l.startswith("//external:"):
      continue
    elif l.startswith("//"):
      l = l[2:]

    path = l.replace(":", "/")
    if path.startswith("/"):
      path = path[1:]

    watch_file(path)
    watched_files.append(path)

  return watched_files

def bazel_labels_to_files(labels):
  files = {}
  for l in labels:
    if l.startswith("//external/") or l.startswith("//external:"):
      continue
    elif l.startswith("//"):
      l = l[2:]

    path = l.replace(":", "/")
    if path.startswith("/"):
      path = path[1:]

    files[path] = None

  return files.keys()

def bazel_run(target, registry="bazel", ns="dev"):
  build_deps = str(local(BAZEL_BUILDFILES_CMD % target)).splitlines()
  source_deps = str(local(BAZEL_SOURCES_CMD % target)).splitlines()
  watch_labels(build_deps)
  watch_labels(source_deps)

  return local("bazel run {t} --define namespace={ns} --define registry={r}".format(t=target, ns=ns, r=registry))

def bazel_target_files(target):
  source_deps = str(local(BAZEL_SOURCES_CMD % target)).splitlines()
  return bazel_labels_to_files(source_deps)


def bazel_build(image, target):
  build_deps = str(local(BAZEL_BUILDFILES_CMD % target)).splitlines()
  watch_labels(build_deps)

  source_deps_files = bazel_target_files(target)

  if source_deps_files == []:
    source_deps_files = ['.']

  custom_build(
    ref = image,
    command = BAZEL_RUN_CMD % target,
    deps = source_deps_files,
    tag="image"
  )
