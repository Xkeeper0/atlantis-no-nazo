@echo off

echo Assembling...
tools\asm6f.exe atlantis-no-nazo.asm -n -c -l %* bin\atlantis-no-nazo.nes

if %ERRORLEVEL% neq 0 goto buildfail


echo SHA1 hash check:
echo 8b8f5266aa4be85a09a5978a3c29119da330ac2b7b1394674c291753545cc385
certutil -hashfile bin\atlantis-no-nazo.nes SHA256 | findstr /V ":"

goto end

:buildfail
echo The build seems to have failed.
goto end

:end
echo on
