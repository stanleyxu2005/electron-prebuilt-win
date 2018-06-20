#!/usr/bin/env bash
set -e

DIST_DIR=dist
export GYP_MSVS_VERSION=2015

if [[ ! "$1" == "--fast" ]]; then
  \rm -rf ${DIST_DIR}
  ./vendors/7z/7z.exe x vendors/electron-*.zip -o${DIST_DIR}
fi

for proj in winax ffi; do
  ./tasks/${proj}/build.sh --update-first
done