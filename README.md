# init

[This repository](https://github.com/katabame/init/) contains scripts for setup environment after (re)installing Operating System.  
Also scripts are automatically bundled and deployed to <https://init.kataba.me> for provide one-liner experience.  

Preference files are provided at [katabame/.preferences](https://github.com/katabame/.preferences) repository.

## Windows

Assumed environment: Windows 11

### PowerShell (43 characters)

```powershell
iwr -o .cmd https://init.kataba.me/win;.cmd
```

### Command Prompt (47 characters)  

```batchfile
curl -fsSL https://init.kataba.me/win>.cmd&.cmd
```

> **Note**  
> `curl` in **cmd.exe** and **powershell.exe** is [**different** command](https://curl.se/windows/microsoft.html).

### Behavior

* Configure DNS over HTTPS
* Install softwares using winget
* Clone [katabame/.preferences](https://github.com/katabame/.preferences) and configure

## Linux

> To be implemented when got motivation

## MacOS

> To be implemented when got MacOS computer
