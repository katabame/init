#!/bin/bash
set -e

if [ -e /Library/Apple/usr/libexec/oah/RosettaLinux/rosetta ]; then
    echo 'Found Rosetta2'
else
    echo '    init.kataba.me Phase 1'
    echo 'Please type following command to install Rosetta2'
    echo 'sudo softwareupdate --install-rosetta'
    exit 1
fi

if [ -e /opt/homebrew/bin/brew ]; then
    brew_formulae=(`curl -fsSLk https://init.kataba.me/mac/brew-formulae | grep -v '#' | grep -v '^$'`)
    brew_casks=(`curl -fsSLk https://init.kataba.me/mac/brew-casks | grep -v '#' | grep -v '^$'`)
    #mas_packages=(`curl -fsSLk https://init.kataba.me/mac/mas-packages | grep -v '#' | grep -v '^$'`)

    for formula in ${brew_formulae[@]}; do
        NONINTERACTIVE=1 HOMEBREW_NO_INSTALL_CLEANUP=1 /opt/homebrew/bin/brew install --quiet ${formula}
    done

    for cask in ${brew_casks[@]}; do
        NONINTERACTIVE=1 HOMEBREW_NO_INSTALL_CLEANUP=1 /opt/homebrew/bin/brew install --quiet --cask ${cask}
    done

    #for mas in ${mas_packages[@]}; do
    #    NONINTERACTIVE=1 HOMEBREW_NO_INSTALL_CLEANUP=1 /opt/homebrew/bin/mas install ${mas}
    #done
else
    echo '    init.kataba.me Phase 2'
    echo 'Please follow instructions to install brew'
    curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh > ~/brew.sh
    chmod +x ~/brew.sh
    NONINTERACTIVE=1 ~/brew.sh > /dev/null
    rm ~/brew.sh
fi
