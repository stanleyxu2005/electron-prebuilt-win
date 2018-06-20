#!/usr/bin/env bash

export NAME=ref
export GIT_REPO="git@github.com:TooTallNate/ref.git"
export COPY_ITEMS="lib node_modules *.md *.json"

./tasks/gyp_build.sh "$@"