rem Only copy this dll because the others are provided
rem by Anaconda or Miniconda
copy /y bin\msvcm90.dll %PREFIX%\ > nul
if errorlevel 1 exit 1

rem Copy binaries to Scripts so that Cmake can find
rem its share files by going one directory up
mkdir %PREFIX%\Scripts
copy /y bin\*.exe %PREFIX%\Scripts > nul
if errorlevel 1 exit 1

xcopy share %PREFIX%\share /E /I > nul
if errorlevel 1 exit 1
