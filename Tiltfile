analytics_settings(enable=False)
disable_snapshots()

load('./bazel.Tiltfile', 'bazel_run', 'bazel_build')

k8s_yaml(bazel_run('//k8s:ns'))

prefixes = { 'grpc': '55', 'rest': '58', 'admin': '59' }

apis = [
  {'num': '000', 'name':'service-one', 'ports': {'grpc': '5000'}},
  {'num': '001', 'name':'authz', 'ports': {'grpc': '5000'}},
  {'num': '002', 'name':'envoy', 'ports': {'rest': '8080', 'admin': '8081'}},
]

for api in apis:
  name = '{}'.format(api['name'])
  ports = []

  for p in api['ports']:
    if name != "envoy":
      ports.append('{pref}{num}:{cport}'.format(
        pref=prefixes[p],
        num = api['num'],
        cport = api['ports'][p])
      )
    else:
      ports.append('{p}:{p}'.format(p=api['ports'][p]))
    print(ports)

  k8s_yaml(bazel_run('//{name}:yaml'.format(name=name)))
  bazel_build('bazel/%s' % name, '//{name}:tarball'.format(name=name))
  k8s_resource(workload=name, port_forwards=ports)

