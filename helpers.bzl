def default_namespace():
  return {
    "%{namespace}": namespace(),
  }

def namespace():
  return "bazel-k8s-envoy"

