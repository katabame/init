# init

[This repository](https://github.com/katabame/init/) contains scripts for setup environment after (re)installing Operating System.
Also scripts are automatically bundled and deployed to <https://init.kataba.me> for provide one-liner experience.

Preference files are provided at [katabame/.preferences](https://github.com/katabame/.preferences) repository.

## Windows

Assumed environment: Windows 11

### PowerShell (34 characters)

```powershell
iwr https://init.kataba.me/win|iex
```

### Command Prompt (51 characters)

```batchfile
curl -fsSL https://init.kataba.me/win/cmd>.cmd&.cmd
```

> **Note**
> `curl` in **cmd.exe** and **powershell.exe** is [**different** command](https://curl.se/windows/microsoft.html).

### Behavior

* Configure DNS over HTTPS
* Install softwares using winget
* Clone [katabame/.preferences](https://github.com/katabame/.preferences) and configure

## macOS

### Command line (43 characters)
```bash
curl -fsSLk https://init.kataba.me/mac|bash
```

### Behavior
* Install softwares using brew and mas
* Clone [katabame/.preferences](https://github.com/katabame/.preferences) and configure

## Linux

### Command line (45 characters)
```bash
curl -fsSLk https://init.kataba.me/linux|bash
```

### Behavior
* Install softwares using apt
* Clone [katabame/.preferences](https://github.com/katabame/.preferences) and configure
