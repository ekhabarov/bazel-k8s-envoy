# Envoy proxy as an API gateway. Built with Bazel. Deployed into Kubernetes.

[Blog post](https://ekhabarov.com/post/envoy-as-an-api-gateway/) with detailed explanation.

## Links
* [Envoy proxy](https://www.envoyproxy.io/)
* [Bazel](https://bazel.build/)
* [Bazelisk](https://github.com/bazelbuild/bazelisk#installation)
* [Kubernetes](https://kubernetes.io/)
* [Tilt](https://tilt.dev/)
* [Minikube](https://minikube.sigs.k8s.io/docs/start/)

## Usage

1. Install and start [minikube](https://minikube.sigs.k8s.io/docs/start/).
1. Install [Bazelisk](https://github.com/bazelbuild/bazelisk#installation).
1. Run Tilt.

```shell
% bazel run //tools:tilt-up

% grpcurl -plaintext \
  -d '{"name": "Bazel"}' \
  127.0.0.1:55000 svc.ServiceOne.Hello

{
  "body": "Hello, Bazel"
}

% curl -i \
  -H 'token: abc' \
  http://localhost:8080/v1/hello\?name\=Bazel


HTTP/1.1 200 OK
content-type: application/json
x-envoy-upstream-service-time: 2
grpc-status: 0
grpc-message:
content-length: 28
date: Tue, 21 Sep 2021 23:33:27 GMT
server: envoy

{
 "body": "Hello, Bazel"
}

% bazel run //tools:tilt-down
```

NOTE: Until `service-one` become available, Envoy will return HTTP 503:
`upstream connect error` or `no healthy upstream`
