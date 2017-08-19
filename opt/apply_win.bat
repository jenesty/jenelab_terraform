@echo off

set APP_NAME=%1
set COMMAND_NAME=apply

call .\opt\terraform_win.bat %APP_NAME% %COMMAND_NAME%
exit /b 0
