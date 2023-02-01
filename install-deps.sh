#!/usr/bin/env bash
set -euo pipefail

luarocks --tree=./lua_modules install --deps-only ./snake-1-0.rockspec
