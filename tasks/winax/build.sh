#!/usr/bin/env bash

export NAME=winax
export GIT_REPO="git@github.com:durs/node-activex.git"
export COPY_ITEMS="*.md *.js *.json"

./tasks/gyp_build.sh "$@"