#!/bin/bash

set -euo pipefail

ARCH=`uname -m`
OS=`uname -s |  tr '[:upper:]' '[:lower:]'`
shift

cd "$BUILD_WORKSPACE_DIRECTORY"
exec $(bazel info output_base)/$(bazel cquery --output=files @tilt_${OS}_${ARCH}//:tilt) "$@"

