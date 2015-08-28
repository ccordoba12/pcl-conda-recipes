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
 -DCMAKE_INSTALL_PREFIX=%LIBRARY_PREFIX% ^
 -DCMAKE_PREFIX_PATH=%LIBRARY_PREFIX%

cmake --build . --config Release

rem mkdir %LIBRARY_PREFIX%\src
mkdir %LIBRARY_PREFIX%\src\gtest

copy /y Release\*.lib %LIBRARY_LIB% > nul
if errorlevel 1 exit 1

cd ..

xcopy include %LIBRARY_INC% /E /I > nul
if errorlevel 1 exit 1

xcopy src  %LIBRARY_PREFIX%\src\gtest\src /E /I > nul
if errorlevel 1 exit 1

xcopy cmake %LIBRARY_PREFIX%\src\gtest\cmake /E /I > nul
if errorlevel 1 exit 1

copy /y CmakeLists.txt %LIBRARY_PREFIX%\src\gtest > nul
if errorlevel 1 exit 1
