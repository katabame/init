@echo off

:: post clean up
echo [*] Setup finished. You may want to restart your computer.
echo:
pause > nul | set /p="[?] Press any key to close this window..."
goto 2> nul & del "%~f0"
exit /b 0
