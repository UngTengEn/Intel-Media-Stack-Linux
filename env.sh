#!/bin/bash

CurDir=$(pwd)
InstallDir=""

if [ ! -z $INTEL_MEDIA_STACK_PATH ]; then
	InstallDir="$INTEL_MEDIA_STACK_PATH"
elif [ ! -z $(echo $CurDir | grep "\/src\/") ]; then
	InstallDir=$(echo $CurDir | sed 's/\/src\/.*//g')
else
	echo "Please set the INTEL_MEDIA_STACK_PATH environment or the stack should be in \"*/src/*\" path."
	exit 1
fi

if [ -z $(echo $LD_LIBRARY_PATH | grep "$InstallDir") ]; then
  [ -z $INTEL_MEDIA_STACK_PATH ] && export INTEL_MEDIA_STACK_PATH=$InstallDir
	export PATH=$InstallDir/bin:$PATH
	export LD_LIBRARY_PATH=$InstallDir/lib64
	export PKG_CONFIG_PATH=$InstallDir/lib64/pkgconfig
	export LIBVA_DRIVERS_PATH=$InstallDir/lib64/dri
fi
