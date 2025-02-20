# init

[This repository](https://github.com/katabame/init/) contains scripts for setup environment after (re)installing Operating System.
Also scripts are automatically bundled and deployed to <https://init.kataba.me> for provide one-liner experience.

Preference files are provided at [katabame/.preferences](https://github.com/katabame/.preferences) repository.

## Legends
* 🟢: Actively Maintained
* 🟨: Passively Maintained
* 🔺: Not Maintained

## Arch 🟢

Assumed environment: Arch (Hyprland)

### Using curl (40 characters)
```bash
curl -L https://init.kataba.me/arch|bash
```

### Using wget (41 characters)
```bash
wget -O- https://init.kataba.me/arch|bash
```


### Behavior
* Install softwares using yay
* Clone [katabame/.preferences](https://github.com/katabame/.preferences) and configure

## Ubuntu 🟨

Assumed environment: Ubuntu 24.10 (Oracular Oriole)

### Using wget (43 characters)
```bash
wget -O- https://init.kataba.me/ubuntu|bash
```

### Using curl (42 characters)
```bash
curl -L https://init.kataba.me/ubuntu|bash
```

### Behavior
* Install softwares using apt
* Clone [katabame/.preferences](https://github.com/katabame/.preferences) and configure


## Windows 🔺

Assumed environment: Windows 11

### PowerShell (34 characters)

```powershell
iwr https://init.kataba.me/win|iex
```

### Command Prompt (45 characters)

```batchfile
curl https://init.kataba.me/win/cmd>.cmd&.cmd
```

> [!Note]
> `curl` in **cmd.exe** and **powershell.exe** is [**different** command](https://curl.se/windows/microsoft.html).

### Behavior

* Configure DNS over HTTPS
* Install softwares using winget
* Clone [katabame/.preferences](https://github.com/katabame/.preferences) and configure


## macOS 🔺

### Command line (39 characters)
```bash
curl -L https://init.kataba.me/mac|bash
```

### Behavior
* Install softwares using brew and mas
* Clone [katabame/.preferences](https://github.com/katabame/.preferences) and configure
