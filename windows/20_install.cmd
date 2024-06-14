@echo off

echo [*] Software installation (Step: %currentSteps%/%totalSteps%)

:: install packages using winget
for /f "tokens=1" %%a in ('curl.exe -fsSL https://init.kataba.me/win/winget-packages') do (
    <nul set /p="Installing %%a... "
    winget install --silent --accept-package-agreements --accept-source-agreements --exact --id %%a > nul 2>&1
if errorlevel 1 (echo Failed) else (echo Done))

:: install WSL2
<nul set /p="Installing Windows Subsystem for Linux... "
    wsl --install --no-launch --distribution Ubuntu > nul 2>&1
    if errorlevel 1 (echo Failed) else (echo Done)
    set /a currentSteps+=1
echo:

echo [*] Preferences installation (Step: %currentSteps%/%totalSteps%)
echo:

:: clone preferences repository
if exist "%programfiles%"\Git\cmd\git.exe (
    <nul set /p="Cloning preferences repository... "
        "%programfiles%"\Git\cmd\git.exe clone https://github.com/katabame/.preferences.git "%userprofile%"\.preferences\ > nul 2>&1
        if errorlevel 1 (echo Failed) else (echo Done)

    if exist "%userprofile%"\.preferences\windows\entrypoint.cmd (
        echo Executing preferences entrypoint...
        call "%userprofile%"\.preferences\windows\entrypoint.cmd
    )
) else (
    echo [^!] Git not found, Skipped.
)
set /a currentSteps+=1
echo:
