# Electron Prebuilt

This project contains a prebuilt [Electron](https://github.com/electron/electron) for Windows x64 with [winax](https://github.com/durs/node-activex) and [ffi](https://github.com/node-ffi/node-ffi) that require rebuild against corresponding header files.

## Getting started

Simply run `npm install electron-prebuilt-win` to install and then launch `electron` from the dist 
directory.

Electron will only search `node_modules` from the application directory or upper, so these prebuilt
node modules `dist/node_modules` will not be able to loaded. Here is a workaround:
```cmd
set "ELECTRON_HOME=path\to\electron-prebuilt-win\dist"
set "PATH=%ELECTRON_HOME%;%PATH%"
start "" electron.exe myapp
```
In the entry point (e.g. main.js), add this line at top
```javascript
const prebuiltModuleDir = process.env.ELECTRON_HOME + '\\resources\\node_modules'
require('module').globalPaths.push(prebuiltModuleDir)
```

## How to build

 1. Download iojs headers for Windows with this `./get_iojs.sh 2.02.2` (from amazon.s3 slow!)
 2. Run `./build.sh` (you can comment out some sub tasks, if your project is file size sensitive)
