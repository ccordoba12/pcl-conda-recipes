@echo off

rem This is needed for pkg-config to detect pcl and eigen3 pc files
set PKG_CONFIG_PATH=%LIBRARY_LIB%\pkgconfig

rem Override distutils VS detection
set DISTUTILS_USE_SDK=1
set MSSdk=1

rem Renames necessary for python-pcl to detect the libraries it needs
for %%x in (io registration segmentation features filters sample_consensus
  surface search kdtree octree common) do (
    copy /y %LIBRARY_LIB%\pcl_%%x_release.lib %LIBRARY_LIB%\pcl_%%x.lib > nul
    if errorlevel 1 exit 1
)

copy /y %LIBRARY_LIB%\flann_cpp_s.lib %LIBRARY_LIB%\flann_cpp.lib > nul
if errorlevel 1 exit 1

rem Compile extension
python setup.py config --compiler=msvc build --compiler=msvc install
if errorlevel 1 exit 1

rem Remove library renames
for %%x in (io registration segmentation features filters sample_consensus
  surface search kdtree octree common) do (
    del %LIBRARY_LIB%\pcl_%%x.lib
    if errorlevel 1 exit 1
)

del %LIBRARY_LIB%\flann_cpp.lib
if errorlevel 1 exit 1
