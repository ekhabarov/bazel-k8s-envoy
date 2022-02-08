analytics_settings(enable=False)
disable_snapshots()

load('./bazel.Tiltfile', 'bazel_run', 'bazel_build', 'bazel_target_files')

k8s_yaml(bazel_run('//k8s:namespace-yaml'))

infra = [
  {'name': 'envoy', 'ports': ['8080:8080', '8081:8081']},
]

for s in infra:
  name = '{}'.format(s['name'])
  ports = s['ports']

  bazel_build('bazel/k8s/%s:image' % name, '//k8s/%s:image' % name)
  k8s_yaml(bazel_run('//k8s/%s:config-map-yaml' % name))
  k8s_yaml(bazel_run('//k8s/%s:deployment-yaml' % name, 'bazel/k8s'))
  k8s_resource(workload=name, port_forwards=ports)

prefixes = { 'grpc': '55' }

apis = [
  {'num': '000', 'name':'service-one', 'ports': {'grpc': '5000'}},
  {'num': '001', 'name':'authz', 'ports': {'grpc': '5000'}},
]

for api in apis:
  name = '{}'.format(api['name'])
  ports = []

  for p in prefixes:
    ports.append('{pref}{num}:{cport}'.format(
      pref=prefixes[p],
      num = api['num'],
      cport = api['ports'][p])
    )
    print(ports)

  k8s_yaml(bazel_run('//{name}:yaml'.format(name=name)))
  bazel_build('bazel/{name}'.format(name=name), '//{name}:image'.format(name=name))
  k8s_resource(workload=name, port_forwards=ports)

