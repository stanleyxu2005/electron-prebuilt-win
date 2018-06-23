#!/usr/bin/env bash
set -e

DIST_DIR=dist
ELECTRON_VER=$(cat version)
ELECTRON_FILE="vendors/electron-v${ELECTRON_VER}-win32-x64.zip"
export GYP_MSVS_VERSION=2015

if [[ ! "$1" == "--fast" ]]; then
  \rm -rf ${DIST_DIR}
  if [ ! -f "${ELECTRON_FILE}" ]; then
    rm \-f vendors/electron-*.zip
    curl -L -k https://npm.taobao.org/mirrors/electron/2.0.3/electron-v${ELECTRON_VER}-win32-x64.zip -o ${ELECTRON_FILE}
    echo "Electron (${ELECTRON_VER}) prebuilt binaries have been saved as ${ELECTRON_FILE}"
  fi
  ./vendors/7z/7z.exe x vendors/electron-*.zip -o${DIST_DIR}
fi

for proj in winax ffi; do
  ./tasks/${proj}/build.sh --update-first
done