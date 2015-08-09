set PKG_CONFIG_PATH=%LIBRARY_LIB%\pkgconfig

python setup.py config --compiler=msvc build --compiler=msvc install
if errorlevel 1 exit 1
