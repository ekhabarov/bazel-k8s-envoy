#!/bin/bash

set -euo pipefail

TOOL=$1
shift

if [[ "$OSTYPE" == "darwin"* ]]; then
  realpath() {
      [[ $1 = /* ]] && echo "$1" || echo "$PWD/${1#./}"
  }
  TOOL_PATH="$(realpath "external/${TOOL}_darwin_x86_64/${TOOL}")"
else
   TOOL_PATH="external/${TOOL}_linux_x86_64/${TOOL}"
fi

TOOL_PATH="$(realpath "${TOOL_PATH}")"

cd "$BUILD_WORKSPACE_DIRECTORY"
exec "${TOOL_PATH}" "$@"

