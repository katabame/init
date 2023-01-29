@echo off
setlocal EnableDelayedExpansion

:listInterfaces
    cls
    call :showBanner
    echo [*] DNS Configuration (Step: %currentSteps%/%totalSteps%)
    set i=1
    for /f "tokens=3*" %%a in (
        'netsh interface show interface ^| findstr . ^| findstr /rv "^Admin.*Name$" ^| findstr /rv "^--*$"'
    ) do (
        echo     [!i!] %%b
        set interfaces[!i!]=%%b
        set /a i+=1
    )
    set /a i-=1
echo:

:chooseInterfaceName
    set /p n="[?] Choose interface to configure (1-!i!)> "
    call :isNumericOnly %n% || goto :chooseInterfaceName
    if %n% lss 1 goto :chooseInterfaceName
    if %n% gtr !i! goto :chooseInterfaceName
    set interfaceName=!interfaces[%n%]!
if defined modifyMode goto :confirmDnsConfiguration

:enterPreferredDnsAddress
    set /p preferredDnsAddress="[?] Enter Preferred DNS IPv4 address> "
    for /f "tokens=1-5 delims=." %%a in ('echo !preferredDnsAddress!') do (
        set a=%%a
        set b=%%b
        set c=%%c
        set d=%%d
        set e=%%e
        if not defined a goto :enterPreferredDnsAddress
        if not defined b goto :enterPreferredDnsAddress
        if not defined c goto :enterPreferredDnsAddress
        if not defined d goto :enterPreferredDnsAddress
        if defined e goto :enterPreferredDnsAddress
        call :isNumericOnly !a! || goto :enterPreferredDnsAddress
        call :isNumericOnly !b! || goto :enterPreferredDnsAddress
        call :isNumericOnly !c! || goto :enterPreferredDnsAddress
        call :isNumericOnly !d! || goto :enterPreferredDnsAddress
        if !a! lss 0 goto :enterPreferredDnsAddress
        if !b! lss 0 goto :enterPreferredDnsAddress
        if !c! lss 0 goto :enterPreferredDnsAddress
        if !d! lss 0 goto :enterPreferredDnsAddress
        if !a! gtr 255 goto :enterPreferredDnsAddress
        if !b! gtr 255 goto :enterPreferredDnsAddress
        if !c! gtr 255 goto :enterPreferredDnsAddress
        if !d! gtr 255 goto :enterPreferredDnsAddress
    )
    if defined modifyMode goto :confirmDnsConfiguration

    :enterPreferredDnsTemplate
    set /p preferredDnsTemplate="[?] Enter Preferred DNS over HTTPS template> "
    for /f "tokens=*" %%a in ('echo !preferredDnsTemplate! ^| find /c "https://"') do (
        if %%a neq 1 goto :enterPreferredDnsTemplate
        for /f "tokens=*" %%a in ('echo !preferredDnsTemplate! ^| find /c "."') do (
            if %%a equ 0 goto :enterPreferredDnsTemplate
        )
    )
if defined modifyMode goto :confirmDnsConfiguration

:enterAlternateDnsAddress
    set /p alternateDnsAddress="[?] Enter Alternate DNS IPv4 address> "
    for /f "tokens=1-5 delims=." %%a in ('echo !alternateDnsAddress!') do (
        set a=%%a
        set b=%%b
        set c=%%c
        set d=%%d
        set e=%%e
        if not defined a goto :enterAlternateDnsAddress
        if not defined b goto :enterAlternateDnsAddress
        if not defined c goto :enterAlternateDnsAddress
        if not defined d goto :enterAlternateDnsAddress
        if defined e goto :enterAlternateDnsAddress
        call :isNumericOnly !a! || goto :enterAlternateDnsAddress
        call :isNumericOnly !b! || goto :enterAlternateDnsAddress
        call :isNumericOnly !c! || goto :enterAlternateDnsAddress
        call :isNumericOnly !d! || goto :enterAlternateDnsAddress
        if !a! lss 0 goto :enterAlternateDnsAddress
        if !b! lss 0 goto :enterAlternateDnsAddress
        if !c! lss 0 goto :enterAlternateDnsAddress
        if !d! lss 0 goto :enterAlternateDnsAddress
        if !a! gtr 255 goto :enterAlternateDnsAddress
        if !b! gtr 255 goto :enterAlternateDnsAddress
        if !c! gtr 255 goto :enterAlternateDnsAddress
        if !d! gtr 255 goto :enterAlternateDnsAddress
    )
if defined modifyMode goto :confirmDnsConfiguration

:enterAlternateDnsTemplate
    set /p alternateDnsTemplate="[?] Enter Alternate DNS over HTTPS template> "
    for /f "tokens=*" %%a in ('echo !alternateDnsTemplate! ^| find /c "https://"') do (
        if %%a neq 1 goto :enterAlternateDnsTemplate
        for /f "tokens=*" %%a in ('echo !alternateDnsTemplate! ^| find /c "."') do (
            if %%a equ 0 goto :enterAlternateDnsTemplate
        )
    )
if defined modifyMode goto :confirmDnsConfiguration

:confirmDnsConfiguration
    cls
    call :showBanner
    echo [*] DNS Configuration (Step: %currentSteps%/%totalSteps%)
    echo     [1] Interface name          : %interfaceName%
    echo     [2] Preferred IPv4 address  : !preferredDnsAddress!
    echo     [3] Preferred DNS over HTTPS: !preferredDnsTemplate!
    echo     [4] Alternate IPv4 address  : !alternateDnsAddress!
    echo     [5] Alternate DNS over HTTPS: !alternateDnsTemplate!
    echo:
    echo     [0] Confirmed and Continue
echo:

:enterPreviewAction
    set /p previewAction="[?] Confirm or edit item (0-5)> "
    call :isNumericOnly %previewAction% || goto :enterPreviewAction
    if %previewAction% lss 0 goto :enterPreviewAction
    if %previewAction% gtr 5 goto :enterPreviewAction
    if defined modifyMode set "modifyMode="
    if %previewAction% equ 1 set modifyMode=1 & goto :listInterfaces
    if %previewAction% equ 2 set modifyMode=1 & goto :enterPreferredDnsAddress
    if %previewAction% equ 3 set modifyMode=1 & goto :enterPreferredDnsTemplate
    if %previewAction% equ 4 set modifyMode=1 & goto :enterAlternateDnsAddress
    if %previewAction% equ 5 set modifyMode=1 & goto :enterAlternateDnsTemplate
    cls
call :showBanner

echo [*] DNS Configuration (Step: %currentSteps%/%totalSteps%)
<nul set /p="Configuring DNS... "
    for /f "tokens=4 delims=," %%a in ('getmac /v /fo csv ^| findstr %interfaceName%') do (
        set interfaceGuid=%%a
        set interfaceGuid=!interfaceGuid:~15,-1!
    )
    netsh interface ipv4 add dnsservers name="%interfaceName%" address="%preferredDnsAddress%" index=1 > nul
    netsh interface ipv4 add dnsservers name="%interfaceName%" address="%alternateDnsAddress%" index=2 > nul
    netsh dnsclient add encryption server="%preferredDnsAddress%" dohtemplate="%preferredDnsTemplate%" autoupgrade=yes udpfallback=no > nul
    netsh dnsclient add encryption server="%alternateDnsAddress%" dohtemplate="%alternateDnsTemplate%" autoupgrade=yes udpfallback=no > nul
    reg add HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Dnscache\InterfaceSpecificParameters\!interfaceGuid!\DohInterfaceSettings\Doh\%preferredDnsAddress% /v DohFlags /t REG_QWORD /d 1 /f > nul
    reg add HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Dnscache\InterfaceSpecificParameters\!interfaceGuid!\DohInterfaceSettings\Doh\%alternateDnsAddress% /v DohFlags /t REG_QWORD /d 1 /f > nul
echo Done
set /a currentSteps+=1
echo:
