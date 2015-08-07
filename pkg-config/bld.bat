@echo off
copy /y bin\pkg-config.exe %PREFIX%\ > nul
xcopy share %PREFIX%\share /E /I > nul
