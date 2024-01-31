#!/bin/bash

. ./env.sh
BuildType="Release"
buildtype="release"
CmakeDebugFlags=""
MesonDebugFlags=""

if [ "$1" == "debug" ]; then
	BuildType="Debug"
	buildtype="debug"
#	CmakeDebugFlags="-DCMAKE_CXX_FLAGS=-fsanitize=address -DCMAKE_C_FLAGS=-fsanitize=address"
#	MesonDebugFlags="-Db_sanitize=address"    
fi

NPROC=$(nproc)
[ $NPROC -gt 4 ] && NPROC=$(( $NPROC - 2 ))

function meson_install() {
	if [ ! -e _build/$BuildType/$1/build.ninja ]; then
    meson setup _build/$BuildType/$1 $1 --prefix="$PWD/_install" --libdir="lib64" --buildtype "$buildtype" ${MesonDebugFlags}
  fi
  ninja -C _build/$BuildType/$1 install
}

function cmake_install() {
	if [ ! -f _build/$BuildType/$1/Makefile ]; then
    cmake -S $1 -B _build/$BuildType/$1 -DCMAKE_INSTALL_PREFIX="$PWD/_install" -DCMAKE_INSTALL_LIBDIR="lib64" -DCMAKE_BUILD_TYPE="$BuildType" $2
  fi
  make -j$NPROC -C _build/$BuildType/$1 install
}

meson_install libva
meson_install libva-utils

cmake_install gmmlib "${CmakeDebugFlags}"
cmake_install media-driver "-DLIBVA_DRIVERS_PATH=$LIBVA_DRIVERS_PATH -DINSTALL_DRIVER_SYSCONF=OFF -DENABLE_KERNELS=ON -DENABLE_NONFREE_KERNELS=ON -DBUILD_CMRTLIB=ON"

cmake_install oneVPL "${CmakeDebugFlags}"
cmake_install oneVPL-intel-gpu "${CmakeDebugFlags}"
