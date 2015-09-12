set BOOSTDIR=%SRC_DIR%\boost

"%SRC_DIR%\boost_1_55_0-msvc-11.0-%ARCH%.exe" /SILENT /DIR="%BOOSTDIR%"
if errorlevel 1 exit 1

xcopy "%BOOSTDIR%\boost" "%LIBRARY_INC%\boost" /s /e /i
if errorlevel 1 exit 1

xcopy "%BOOSTDIR%"\lib%ARCH%-msvc-11.0\*vc110-mt-1_55.lib "%LIBRARY_LIB%"
if errorlevel 1 exit 1

xcopy "%BOOSTDIR%"\lib%ARCH%-msvc-11.0\*vc110-mt-1_55.dll "%LIBRARY_BIN%"
if errorlevel 1 exit 1
