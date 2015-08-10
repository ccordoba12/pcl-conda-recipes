set PKG_CONFIG_PATH=%LIBRARY_LIB%\pkgconfig

rem Library renames necessary for python-pcl to compile
for %%x in (io registration segmentation features filters sample_consensus surface search kdtree octree common) do (
    copy %LIBRARY_LIB%\pcl_%%x_release.lib %LIBRARY_LIB%\pcl_%%x.lib
    if errorlevel 1 exit 1
)

copy %LIBRARY_LIB%\flann_cpp_s.lib %LIBRARY_LIB%\flann_cpp.lib
if errorlevel 1 exit 1

python setup.py config --compiler=msvc build --compiler=msvc install
if errorlevel 1 exit 1
