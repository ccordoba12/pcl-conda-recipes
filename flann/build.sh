#!/bin/bash
mkdir build
cd build

CMAKE_GENERATOR="Unix Makefiles"
CMAKE_ARCH="-m"$ARCH

if [ "$(uname)" == "Darwin" ]; then
  cmake .. -G "$CMAKE_GENERATOR" \
    -DBUILD_MATLAB_BINDINGS:BOOL=OFF \
    -DBUILD_PYTHON_BINDINGS:BOOL=OFF \
    -DCMAKE_INSTALL_PREFIX=$PREFIX \
    -DCMAKE_OSX_DEPLOYMENT_TARGET=''
fi

if [ "$(uname)" == "Linux" ]; then
  export CFLAGS="$CFLAGS $CMAKE_ARCH"
  export LDLAGS="$LDLAGS $CMAKE_ARCH"

  cmake .. -G "$CMAKE_GENERATOR" \
    -DBUILD_MATLAB_BINDINGS:BOOL=OFF \
    -DBUILD_PYTHON_BINDINGS:BOOL=OFF \
    -DCMAKE_INSTALL_PREFIX=$PREFIX   \
    -DCMAKE_C_COMPILER="${PREFIX}"/bin/gcc \
    -DCMAKE_CXX_COMPILER="${PREFIX}"/bin/g++
fi

make
make install
