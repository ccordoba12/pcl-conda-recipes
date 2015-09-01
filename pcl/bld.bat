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
  -Wno-dev ^
  -DCMAKE_BUILD_TYPE=Release ^
  -DCMAKE_INSTALL_PREFIX=%LIBRARY_PREFIX% ^
  -DCMAKE_PREFIX_PATH=%LIBRARY_PREFIX% ^
  -DGTEST_SRC_DIR=%LIBRARY_PREFIX%\src\gtest ^
  -DBUILD_global_tests=ON

cmake --build . --config Release --target ALL_BUILD 1>output.txt 2>&1
if errorlevel 1 exit 1

cmake --build . --config Release --target INSTALL
if errorlevel 1 exit 1

rem Add all tests to the package
copy /y bin\test*.exe %LIBRARY_BIN% > nul
if errorlevel 1 exit 1

rem Copy files needed for tests
set PCL_TEST_FILES=%LIBRARY_BIN%\pcl_test_files
mkdir %PCL_TEST_FILES%

copy /y ..\test\*.pcd %PCL_TEST_FILES% > nul
if errorlevel 1 exit 1

copy /y ..\test\*.txt %PCL_TEST_FILES% > nul
if errorlevel 1 exit 1

copy /y ..\test\*.py %PCL_TEST_FILES% > nul
if errorlevel 1 exit 1

copy /y ..\test\*.jpg %PCL_TEST_FILES% > nul
if errorlevel 1 exit 1

copy /y ..\test\*.vtk %PCL_TEST_FILES% > nul
if errorlevel 1 exit 1

copy /y ..\test\kdtree\*.xml %PCL_TEST_FILES% > nul
if errorlevel 1 exit 1

xcopy ..\test\grabber_sequences %PCL_TEST_FILES%\grabber_sequences /E /I > nul
if errorlevel 1 exit 1

copy /y ..\people\data\*.yaml %PCL_TEST_FILES% > nul
if errorlevel 1 exit 1
