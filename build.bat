@echo off

echo Assembling...
tools\asm6f.exe atlantis-no-nazo.asm -n -c -l %* bin\atlantis-no-nazo.nes

if %ERRORLEVEL% neq 0 goto buildfail


echo SHA1 hash check:
echo 214ba9292d5de52d29a6e2ad3a0162caf95b94caa14b0b167915aa8fb8c3dec6
certutil -hashfile bin\atlantis-no-nazo.nes SHA256 | findstr /V ":"

goto end

:buildfail
echo The build seems to have failed.
goto end

:end
echo on
