@echo off
set BIOUTPUT=1

python tools\create_prep.py %*

if exist a3 (
  rmdir a3
)
mklink /j a3 include\a3

mkdir x
mkdir x\grad_adminmessages
if exist x\grad_adminmessages\addons (
  rmdir x\grad_adminmessages\addons
)
mklink /j x\grad_adminmessages\addons addons

IF [%1] == [] (
  tools\hemtt.exe build
) ELSE (
  tools\hemtt.exe release
)

set BUILD_STATUS=%errorlevel%

rmdir a3
rmdir x\grad_adminmessages\addons
rmdir x\grad_adminmessages
rmdir x

if %BUILD_STATUS% neq 0 (
  echo Build failed
  exit /b %errorlevel%
) else (
  echo Build successful
  sleep 1
  EXIT
)