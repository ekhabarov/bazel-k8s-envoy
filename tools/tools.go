//go:build tools

package tools

// need it here for proper update deps with `go mod tidy` and then with bazel run //:deps.
import _ "github.com/vmware-tanzu/carvel-ytt/cmd/ytt"
