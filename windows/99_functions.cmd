@echo off
setlocal

:: prevent execute as a normal script
exit /b 0

:isNumericOnly
    set value=%1
    if defined value set value=%value:0=%
    if defined value set value=%value:1=%
    if defined value set value=%value:2=%
    if defined value set value=%value:3=%
    if defined value set value=%value:4=%
    if defined value set value=%value:5=%
    if defined value set value=%value:6=%
    if defined value set value=%value:7=%
    if defined value set value=%value:8=%
    if defined value set value=%value:9=%
if defined value (exit /b 1) else (exit /b 0)

:showBanner
    echo:
    echo ------------------------------------------------------------
    echo                     init.kataba.me / win                    
    echo:
    echo     Commit SHA: %commitSHA%
    echo ------------------------------------------------------------
echo:
