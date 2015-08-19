#!/bin/bash
mkdir build
cd build

CMAKE_GENERATOR="Unix Makefiles"
CMAKE_ARCH="-m"$ARCH

if [ "$(uname)" == "Linux" ]; then
  export CFLAGS="$CFLAGS $CMAKE_ARCH"
  export LDLAGS="$LDLAGS $CMAKE_ARCH"

  cmake .. -G "$CMAKE_GENERATOR" \
    -DCMAKE_BUILD_TYPE=Release \
    -DBUILD_apps:BOOL=OFF \
    -DBUILD_tools:BOOL=OFF \
    -DBUILD_examples:BOOL=OFF \
    -DBUILD_global_tests:BOOL=OFF \
    -DCMAKE_DISABLE_FIND_PACKAGE_OpenNI:BOOL=TRUE \
    -DCMAKE_DISABLE_FIND_PACKAGE_Qt4:BOOL=TRUE \
    -DCMAKE_DISABLE_FIND_PACKAGE_VTK:BOOL=TRUE \
    -DBUILD_outofcore:BOOL=AUTO_OFF \
    -DBUILD_people:BOOL=AUTO_OFF \
    -DBUILD_SHARED_LIBS:BOOL=ON \
    -DCMAKE_INSTALL_PREFIX=$PREFIX \
    -DBOOST_LIBRARYDIR=$PREFIX/lib \
    -DCMAKE_C_COMPILER="${PREFIX}"/bin/gcc \
    -DCMAKE_CXX_COMPILER="${PREFIX}"/bin/g++ \
    -DCMAKE_PREFIX_PATH="${PREFIX}" \
    -DCMAKE_EXE_LINKER_FLAGS=-L"${PREFIX}"/lib \
    -DCMAKE_MODULE_LINKER_FLAGS=-L"${PREFIX}"/lib \
    -DCMAKE_SHARED_LINKER_FLAGS=-L"${PREFIX}"/lib
fi


if [ "$(uname)" == "Darwin" ]; then
  cmake .. -G "$CMAKE_GENERATOR" \
    -DCMAKE_BUILD_TYPE=Release \
    -DBUILD_apps:BOOL=OFF \
    -DBUILD_tools:BOOL=OFF \
    -DBUILD_examples:BOOL=OFF \
    -DBUILD_global_tests:BOOL=OFF \
    -DCMAKE_DISABLE_FIND_PACKAGE_OpenNI:BOOL=TRUE \
    -DCMAKE_DISABLE_FIND_PACKAGE_Qt4:BOOL=TRUE \
    -DCMAKE_DISABLE_FIND_PACKAGE_VTK:BOOL=TRUE \
    -DBUILD_outofcore:BOOL=AUTO_OFF \
    -DBUILD_people:BOOL=AUTO_OFF \
    -DBUILD_SHARED_LIBS:BOOL=ON \
    -DCMAKE_INSTALL_PREFIX=$PREFIX \
    -DBOOST_LIBRARYDIR=$PREFIX/lib \
    -DCMAKE_PREFIX_PATH="${PREFIX}" \
    -DCMAKE_OSX_DEPLOYMENT_TARGET=''
fi


make
make install
