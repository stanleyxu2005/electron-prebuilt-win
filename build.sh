#!/usr/bin/env bash

DIST_DIR=dist

\rm -rf ${DIST_DIR}
./vendors/7z/7z.exe x vendors/electron-*.zip -o${DIST_DIR}
./tasks/winax/build.sh --update-first
