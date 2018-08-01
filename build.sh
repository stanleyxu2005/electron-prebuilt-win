#!/usr/bin/env bash
set -e

DIST_DIR=dist
ELECTRON_VER=$(cat version)
if [[ ! -z $1 ]]; then
  ELECTRON_VER=$1
fi

echo "Building v${ELECTRON_VER}..."
ELECTRON_FILE="electron-v${ELECTRON_VER}-win32-x64.zip"
ELECTRON_FULLPATH="vendors/${ELECTRON_FILE}"
export GYP_MSVS_VERSION=2015

if [[ ! "$1" == "--fast" ]]; then
  \rm -rf ${DIST_DIR}
  if [ ! -f "${ELECTRON_FULLPATH}" ]; then
    rm \-f vendors/electron-*.zip
    curl -L -k https://npm.taobao.org/mirrors/electron/${ELECTRON_VER}/${ELECTRON_FILE} -o ${ELECTRON_FULLPATH}
    echo "Electron (${ELECTRON_VER}) prebuilt binaries have been saved as ${ELECTRON_FULLPATH}"
  fi
  ./vendors/7z/7z.exe x "${ELECTRON_FULLPATH}" -o${DIST_DIR}
fi

for proj in winax ffi; do
  ./tasks/${proj}/build.sh --update-first
done