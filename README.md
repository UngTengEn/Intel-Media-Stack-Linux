# Intel Media Stack vscode Workspace (Linux)
This document describes how to build the binaries.

## Prerequisites

Install all the prerequisites on your Linux Distribution 

- Build Tools cmake, meson, ninja, pkgconfig.
- C and C++ compiler.
- Development dependencies are mainly base on libva build dependencies.

## Clone and Build
```
git clone https://github.com/UngTengEn/Intel-Media-Stack-Linux.git --recursive
```

Open the workspace in the folder with Visual Studio Code.

In Visual Studio Code menu, goto Terminal > Run Task..., run "Build All | Release".

The binaries and programs will build in _install/Release/.

Configure most of your build environtments in env.sh

Note: make sure most paths consist of only ascii characters and no spaces.

## Extra Tools

### Gstreamer

1. Open a new Terminal in Visual Studio Code.
2. Run ". ./env.sh" from project root path.  This should set the build environments.
3. Run "./build_gstreamer.sh [release|debug]".  This will git clone gstreamer or build it.
