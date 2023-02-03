#!/usr/bin/env bash
set -euo pipefail

# Changes work directory to module root
module_root="$(dirname "$(realpath "$0")")"
cd "$module_root"

# Gets install path
install_path="${1:-}"
test -d "$install_path" || {
  echo "First argument must be an absolute tree path" >&2
  return 1
}

# Builds and installs module
luarocks make --tree="$install_path" ./*.rockspec

# Cleans up
rm -rf *.so *.o
