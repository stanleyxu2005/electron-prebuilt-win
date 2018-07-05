#!/usr/bin/env bash

VER=$1
if [[ -z ${VER} ]]; then
  echo "Usage: \"$0 1.6.10\""
  exit 1
fi

DIST_DIR=vendors
IOJS_DIR=iojs
if [ ! -d ${IOJS_DIR} ]; then
  mkdir -p ${IOJS_DIR}/win-x64
  mkdir -p ${IOJS_DIR}/win-x86
  wget https://atom.io/download/electron/v${VER}/SHASUMS256.txt -O ${IOJS_DIR}/SHASUMS256.txt
  wget https://atom.io/download/electron/v${VER}/iojs-v${VER}.tar.gz -O ${IOJS_DIR}/iojs-v${VER}.tar.gz
  wget https://atom.io/download/electron/v${VER}/win-x64/iojs.lib -O ${IOJS_DIR}/win-x64/iojs.lib
  wget https://atom.io/download/electron/v${VER}/win-x86/iojs.lib -O ${IOJS_DIR}/win-x86/iojs.lib
  ZIP_FILE=${DIST_DIR}/iojs.zip
  \rm -f ${ZIP_FILE} && zip -r ${ZIP_FILE} ${IOJS_DIR}
  echo "iojs (${VER}) header files have been saved as ${ZIP_FILE}"
  \rm -rf ${IOJS_DIR}
fi

#echo ${VER} > version
