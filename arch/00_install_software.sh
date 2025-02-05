#!/sbin/bash
set -e

echo '────────────────────────────────────────────────────'
echo '               init.kataba.me Phase 0'
echo '                 Updating system...'
echo 'Commit SHA: ::COMMIT_SHA::'
echo '────────────────────────────────────────────────────'

sudo pacman -Syu --noconfirm
type -p curl >/dev/null || sudo pacman -S --noconfirm curl

sudo pacman -S --needed --noconfirm git base-devel
git clone https://aur.archlinux.org/yay-bin.git
cd ./yay-bin
makepkg -si --noconfirm
cd ../
rm -rf ./yay-bin

echo '────────────────────────────────────────────────────'
echo '               init.kataba.me Phase 1'
echo '               Installing software...'
echo '────────────────────────────────────────────────────'

# yay
packages=(`curl -fsSLk https://init.kataba.me/arch/packages | grep -v '#' | grep -v '^$'`)
sudo yay -S --noconfirm ${packages[@]}

# obs
sudo usermod -aG video katabame

# xremap
echo 'uinput' | sudo tee /etc/modules-load.d/uinput.conf
echo 'KERNEL=="uinput", GROUP="input", TAG+="uaccess"' | sudo tee /etc/udev/rules.d/99-input.rules
