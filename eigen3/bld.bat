@echo off

mkdir build
cd build

rem Need to handle Python 3.x case at some point (Visual Studio 2010)
if %ARCH%==32 (
  if %PY_VER% LSS 3 (
    set CMAKE_GENERATOR="Visual Studio 9 2008"
  )
)

if %ARCH%==64 (
  if %PY_VER% LSS 3 (
    set CMAKE_GENERATOR="Visual Studio 9 2008 Win64"
  )
)

rem eigen3.pc (i.e. pkg-config) file is needed by python-pcl
mkdir "%LIBRARY_LIB%\pkgconfig"
set PKG_CONFIG_LIBDIR=%LIBRARY_LIB%

cmake .. -G %CMAKE_GENERATOR% ^
 -DCMAKE_BUILD_TYPE=Release ^
 -DINCLUDE_INSTALL_DIR=%LIBRARY_INC% ^
 -DEIGEN_BUILD_PKGCONFIG:BOOL=ON

cmake --build . --config Release --target ALL_BUILD
cmake --build . --config Release --target INSTALL
