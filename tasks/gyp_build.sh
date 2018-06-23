#!/usr/bin/env bash
set -e

cd $(dirname $0)/${NAME}
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
GIT_PULL=0

if [ ! -d ${SRC_DIR} ]; then
  echo "Downloading source code from git repository..."
  git clone ${GIT_REPO} ${SRC_DIR}
elif [ $# -gt 0 ] && [ "$1" == "--update-first" ]; then
  GIT_PULL=1
fi

cd ${SRC_DIR}
if [ "${GIT_PULL}" -ne 0 ]; then
  echo "Updating $NAME from git repository..."
  git checkout -- .
  git fetch origin -p
  git pull --rebase
fi

echo "Install dependencies..."
yarn install --prod --verbose

echo "Building $NAME for Electron ${ELECTRON_VER} on Windows (x64)..."
rm -rf ${GYP_BUILD_DIR}
BUILD_LOG=msbuild.log
node-gyp rebuild ${GYP_ARGS} \
  --runtime=electron --target=${ELECTRON_VER} --target_arch=x64 \
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
for n in ${COPY_ITEMS}; do
  cp -r ${SRC_DIR}/${n} ${DIST_DIR}
done

