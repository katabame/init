#!/usr/bin/bash
set -e

echo '────────────────────────────────────────────────────'
echo '               init.kataba.me Phase 0'
echo '                 Updating system...'
echo 'Commit SHA: ::COMMIT_SHA::'
echo '────────────────────────────────────────────────────'

sudo apt-get update
sudo apt-get upgrade -y --no-install-recommends
type -p curl >/dev/null || sudo apt-get install -y --no-install-recommends curl

echo '────────────────────────────────────────────────────'
echo '               init.kataba.me Phase 1'
echo '               Installing hyprland...'
echo '────────────────────────────────────────────────────'

# hyprland
curl https://hypr.kataba.me/build.sh | bash

echo '────────────────────────────────────────────────────'
echo '               init.kataba.me Phase 2'
echo '               Installing software...'
echo '────────────────────────────────────────────────────'

# apt
apt_packages=(`curl -fsSLk https://init.kataba.me/linux/apt-packages | grep -v '#' | grep -v '^$'`)
sudo apt-get install -y --no-install-recommends ${apt_packages[@]}
#for package in ${apt_packages[@]}; do
#    sudo apt-get install -y --no-install-recommends ${package}
#done

# flatpak
flatpak_packages=(`curl -fsSLk https://init.kataba.me/linux/flatpak-packages | grep -v '#' | grep -v '^$'`)
flatpak install -y flathub ${flatpak_packages[@]}
#for package in ${flatpak_packages[@]}; do
#    flatpak install -y flathub ${package}
#done

# obs
sudo usermod -aG video katabame

# discord
wget -O discord.deb 'https://discord.com/api/download?platform=linux&format=deb'
sudo apt-get install -y --no-install-recommends ./discord.deb
rm ./discord.deb

# chrome
wget -O chrome.deb https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo apt-get install -y --no-install-recommends ./chrome.deb
rm ./chrome.deb

# warp
wget -O warp.deb https://releases.warp.dev/stable/v0.2024.06.04.08.02.stable_03/warp-terminal_0.2024.06.04.08.02.stable.03_amd64.deb
sudo apt-get install -y --no-install-recommends ./warp.deb
rm ./warp.deb

# 1password
wget -O 1password.deb https://downloads.1password.com/linux/debian/amd64/stable/1password-latest.deb
sudo apt-get install -y --no-install-recommends ./1password.deb
rm ./1password.deb

# steam
wget -O steam.deb https://repo.steampowered.com/steam/archive/precise/steam_latest.deb
sudo apt-get install -y --no-install-recommends ./steam.deb
rm ./steam.deb

# cursor
wget -O cursor.appimage https://downloader.cursor.sh/linux/appImage/x64

# lunarClient
wget -O lunarclient.appimage https://launcherupdates.lunarclientcdn.com/Lunar%20Client-3.2.10.AppImage

# xremap
wget -O xremap.zip https://github.com/xremap/xremap/releases/download/v0.10.0/xremap-linux-x86_64-wlroots.zip
unzip ./xremap.zip
sudo mv ./xremap /usr/local/bin
sudo usermod -aG input $USER
echo 'KERNEL=="uinput", GROUP="input", TAG+="uaccess"' | sudo tee /etc/udev/rules.d/input.rules
rm ./xremap.zip

# gh
(type -p wget >/dev/null || (sudo apt update && sudo apt-get install wget -y)) && \
sudo mkdir -p -m 755 /etc/apt/keyrings && \
wget -qO- https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo tee /etc/apt/keyrings/githubcli-archive-keyring.gpg > /dev/null && \
sudo chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg && \
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null && \
sudo apt-get update && \
sudo apt install -y --no-install-recommends gh

# virtualbox
wget -O virtualbox.deb https://download.virtualbox.org/virtualbox/7.0.18/virtualbox-7.0_7.0.18-162988~Ubuntu~noble_amd64.deb
sudo apt-get install -y --no-install-recommends ./virtualbox.deb
rm ./virtualbox.deb
sudo usermod -aG vboxusers katabame
