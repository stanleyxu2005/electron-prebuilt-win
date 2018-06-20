#!/usr/bin/env bash

export NAME=ffi
export GIT_REPO="git@github.com:node-ffi/node-ffi.git"
export COPY_ITEMS="lib node_modules *.md *.json"

./tasks/gyp_build.sh "$@"

echo "[NOTICE] Module \"ref\" is not built againt local nodejs correctly. Need to rebuild..."
./tasks/ref/build.sh "$@"
rm -rf dist/resources/node_modules/ffi/node_modules/ref
mv dist/resources/node_modules/ref dist/resources/node_modules/ffi/node_modules
rm -rf dist/resources/node_modules/ffi/node_modules/ref/node_modules
