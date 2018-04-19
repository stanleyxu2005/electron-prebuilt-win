#!/usr/bin/env bash

VER=$1
if [[ -z ${VER} ]]; then
  echo "Usage: \"$0 1.6.10\""
  exit 1
fi

IOJS_DIR=vendors/iojs
if [ ! -d ${IOJS_DIR} ]; then
  mkdir -p ${IOJS_DIR}/win-x64
  mkdir -p ${IOJS_DIR}/win-x86
  wget https://atom.io/download/electron/v${VER}/SHASUMS256.txt -O ${IOJS_DIR}/SHASUMS256.txt
  wget https://atom.io/download/electron/v${VER}/iojs-v${VER}.tar.gz -O ${IOJS_DIR}/iojs-v${VER}.tar.gz
  wget https://atom.io/download/electron/v${VER}/win-x64/iojs.lib -O ${IOJS_DIR}/win-x64/iojs.lib
  wget https://atom.io/download/electron/v${VER}/win-x86/iojs.lib -O ${IOJS_DIR}/win-x86/iojs.lib
  echo "iojs (${VER}) header files have been saved to ${IOJS_DIR}"
  cd vendors && zip -r iojs.zip iojs && cd -
  \rm -rf ${IOJS_DIR}
fi

DIST_DIR=dist
wget https://github.com/electron/electron/releases/download/v${VER}/electron-v${VER}-win32-x64.zip -O ${DIST_DIR}/electron-win32-x64.zip
echo "Electron (${VER}) prebuilt binaries have been saved to ${DIST_DIR}"
