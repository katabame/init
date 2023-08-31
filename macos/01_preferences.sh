#!/bin/bash
gh auth login --hostname github.com

cd ~/
git clone https://github.com/katabame/.preferences
git clone https://github.com/katabame/.preferences.private

# ssh
ln -fs ~/.preferences.private/.ssh/config ~/.ssh/config
ln -fs ~/.preferences.private/.ssh/known_hosts ~/.ssh/known_hosts
ln -fs ~/.preferences.private/.ssh/id_ed25519 ~/.ssh/id_ed25519
ln -fs ~/.preferences.private/.ssh/id_ed25519.pub ~/.ssh/id_ed25519.pub

# fish
ln -fs ~/.preferences/common/.config/fish/config.fish ~/.config/fish/config.fish
ln -fs ~/.preferences/common/.config/fish/functions/fish_prompt.fish ~/.config/fish/functions/fish_prompt.fish

# karabiner
ln -fs ~/.preferences/macos/karabiner.edn ~/.config/karabiner.edn
goku

# sudo with TouchID
#echo "auth       sufficient     pam_tid.so" | sudo tee -a /etc/pam.d/sudo
