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

cmake .. -G %CMAKE_GENERATOR% ^
 -DCMAKE_BUILD_TYPE=Release ^
 -DCMAKE_INSTALL_PREFIX=%LIBRARY_PREFIX% ^
 -DCMAKE_PREFIX_PATH=%LIBRARY_PREFIX%

cmake --build . --config Release --target ALL_BUILD
if errorlevel 1 exit 1

cmake --build . --config Release --target INSTALL
if errorlevel 1 exit 1
