#!/usr/bin/env bash
set -e

# configurable
NAME=winax
GIT_REPO="git@github.com:durs/node-activex.git"

cd $(dirname $0)
ROOT_DIR=$(pwd)/../..
ELECTRON_DIR=${ROOT_DIR}/dist
ELECTRON_VER=$(cat ${ROOT_DIR}/version)
if [ -z ${ELECTRON_VER} ] || [ ! -d ${ROOT_DIR}/tasks ]; then
  echo "The build file is broken"
  exit 1
fi

# expert settings
SRC_DIR=github
GYP_BUILD_DIR=${SRC_DIR}/build

#LIBZMQ_FILE=libs/libzmq-4.2.2-x64.lib

if [ ! -d ${SRC_DIR} ]; then
  echo "Downloading source code from git repository..."
  git clone ${GIT_REPO} ${SRC_DIR}
  #mkdir ${SRC_DIR}/windows/lib -p
  #cp ${LIBZMQ_FILE} ${SRC_DIR}/windows/lib/libzmq.lib
  $1=""
fi

cd ${SRC_DIR}
if [[ "$1" == "--update-first" ]]; then
  echo "Updating $NAME from git repository..."
  git reset HEAD * -q
  git fetch origin -p -q
  git pull --rebase -q
fi

# https://github.com/durs/node-activex/issues/30
#echo "Install dependencies..."
#npm i --prod --verbose

echo "Building $NAME for Electron ${ELECTRON_VER} on Windows (x64)..."
rm -rf ${GYP_BUILD_DIR}
BUILD_LOG=msbuild.log
node-gyp rebuild ${GYP_ARGS} \
  --target_arch=x64 \
  --runtime=electron --target=${ELECTRON_VER} \
  --build-from-source > ${BUILD_LOG}
if [ $? -ne 0 ]; then
  echo "Failed to build, please check ${BUILD_LOG}"
  exit 1
fi
\rm ${BUILD_LOG}
cd -

DIST_DIR=${ELECTRON_DIR}/resources/node_modules/${NAME}
mkdir -p ${DIST_DIR}/build/Release
cp ${GYP_BUILD_DIR}/Release/*.node ${DIST_DIR}/build/Release
#cp -r lib ${DIST_DIR}
#for n in node_modules *.md *.js *.json; do
#  cp -r ${SRC_DIR}/${n} ${DIST_DIR}
#done

#echo "Run \"npm test\" to verify"
