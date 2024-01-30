#!/bin/bash

CurDir=$(pwd)
InstallDir="$PWD/_install"

if [ -z $(echo $LD_LIBRARY_PATH | grep "$InstallDir") ]; then
	export PATH=$InstallDir/bin:$PATH
	export LD_LIBRARY_PATH=$InstallDir/lib64
	export PKG_CONFIG_PATH=$InstallDir/lib64/pkgconfig
	export LIBVA_DRIVERS_PATH=$InstallDir/lib64/dri
fi
