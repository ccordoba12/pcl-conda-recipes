@echo off

mkdir build
cd build

rem Need to handle Python 3.x case at some point (Visual Studio 2010)
if %ARCH%==32 (
  if %PY_VER% LSS 3 (
    set CMAKE_GENERATOR="Visual Studio 11 2012"
  )
)

if %ARCH%==64 (
  if %PY_VER% LSS 3 (
    set CMAKE_GENERATOR="Visual Studio 11 2012 Win64"
  )
)

cmake .. -G %CMAKE_GENERATOR% ^
   -Wno-dev ^
   -DCMAKE_BUILD_TYPE=Release ^
   -DCMAKE_INSTALL_PREFIX=%LIBRARY_PREFIX% ^
   -DCMAKE_PREFIX_PATH=%LIBRARY_PREFIX% ^
   -DBUILD_MATLAB_BINDINGS=OFF ^
   -DBUILD_PYTHON_BINDINGS=OFF

cmake --build . --config Release --target ALL_BUILD 1>output.txt 2>&1
if errorlevel 1 exit 1

cmake --build . --config Release --target INSTALL
if errorlevel 1 exit 1

rem Copy VS 2012 runtime libraries
copy C:\Windows\System32\vcomp110.dll %LIBRARY_BIN%
if errorlevel 1 exit 1
