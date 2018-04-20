# Electron Prebuilt

This is a mirror repo of Electron distributions and node modules that 
require rebuild against corresponding header files. 

<!--
## How to build zeromq.js

 * Be sure you have [Visual C++ Build Tools](http://go.microsoft.com/fwlink/?LinkId=691126) using the *Default Install* option installed.
 * Add an environment variable `GYP_MSVS_VERSION` is set to `2015`.
 * Download the latest Electron Windows x64 build into `vendors\electron`
 * Manually download corresponding iojs headers and put them into a local HTTP server or modify build.sh (at line 10)
 * Run `./build.sh`

After the build is successful, you can launch `vendors\electron\electron.exe test` to test.
-->

## Quick Build

 1. Run `./iojs.sh 1.8.4` (need bypass GFW)
 2. Run `git add version vendors`
 3. Run `./build.sh`
 4. Update version in package.json 
 5. Run `npm publish`
 
## How to load prebuilt modules

Electron will only search `node_modules` from the application directory or upper, so these prebuilt
node modules `dist/node_modules` will not be able to loaded. Here is a workaround:
```
set "ELECTRON_HOME=path\to\electron-prebuilt-win\dist"
set "PATH=%ELECTRON_HOME%;%PATH%"
start "" electron.exe myapp
```
In the entry point (e.g. main.js), add this line at top
```
const prebuiltModuleDir = process.env.ELECTRON_HOME + '\\resources\\node_modules'
require('module').globalPaths.push(prebuiltModuleDir)
```
