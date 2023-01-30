@echo off
cls
setlocal

set commitSHA=::COMMIT_SHA::
set currentSteps=1
set totalSteps=::TOTAL_STEPS::

call :showBanner

:: check administrative privileges and promote when not
openfiles > nul 2>&1
if errorlevel 1 (
    <nul set /p="[?] Requesting administrative privileges... "
    powershell start-process "%~f0" -verb runas > nul
    if errorlevel 1 (
        echo Failed
        echo [^!] Unable to continue, aborted.
        goto 2> nul & del "%~f0"
        exit /b 1
    ) else (
        echo Succeeded
        echo [*] Continue setup on newly opened terminal window.
        exit /b 0
    )
)
