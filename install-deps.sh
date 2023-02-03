#!/usr/bin/env bash
set -euo pipefail

# Changes work directory to project root
project_root="$(dirname "$(realpath "$0")")"
cd "$project_root"

rockspec="$(echo $project_root/snake-*.rockspec)"
tree="$project_root/lua_modules"

# Installs remote dependencies
luarocks --tree="$tree" install --deps-only "$rockspec"

# Installs local dependencies
./terminal/install.sh "$(realpath "$tree")"
