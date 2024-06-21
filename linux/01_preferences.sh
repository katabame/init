#!/usr/bin/bash

echo '────────────────────────────────────────────────────'
echo '               init.kataba.me Phase 3'
echo '               Applying preference...'
echo '────────────────────────────────────────────────────'

gh auth login --hostname github.com

cd ~
git clone --depth 1 --branch linux https://github.com/katabame/.preferences
git clone --depth 1 --branch linux https://github.com/katabame/.preferences.private

bash ~/.preferences/entrypoint.sh
bash ~/.preferences.private/entrypoint.sh
