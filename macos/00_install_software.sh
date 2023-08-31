#!/bin/bash
set -e

# Install rosetta
sudo softwareupdate --install-rosetta

# Install brew
eval "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

brew_formulae=(`cat -s brew-formulae.txt | grep -v '#' | grep -v '^$'`)
brew_casks=(`cat -s brew-casks.txt | grep -v '#' | grep -v '^$'`)
mas_packages=(`cat -s mas-packages.txt | grep -v '#' | grep -v '^$'`)

for formula in ${brew_formulae[@]}; do
    /opt/homebrew/bin/brew install --quiet ${formula}
done

for cask in ${brew_casks[@]}; do
    /opt/homebrew/bin/brew install --quiet --cask ${cask}
done

for mas in ${mas_packages[@]}; do
    /opt/homebrew/bin/mas install ${mas}
done
