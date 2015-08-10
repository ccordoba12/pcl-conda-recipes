rem This needed for pkg-config to detect pcl and eigen3 pc files
set PKG_CONFIG_PATH=%LIBRARY_LIB%\pkgconfig

rem Renames necessary for python-pcl to detect the libraries it needs
for %%x in (io registration segmentation features filters sample_consensus surface search kdtree octree common) do (
    copy %LIBRARY_LIB%\pcl_%%x_release.lib %LIBRARY_LIB%\pcl_%%x.lib
    if errorlevel 1 exit 1
)

copy %LIBRARY_LIB%\flann_cpp_s.lib %LIBRARY_LIB%\flann_cpp.lib
if errorlevel 1 exit 1

rem Compile extension
python setup.py config --compiler=msvc build --compiler=msvc install
if errorlevel 1 exit 1
