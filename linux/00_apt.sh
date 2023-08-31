#!/bin/bash
set -e

sudo apt update
sudo apt upgrade -y --no-install-recommends

apt_packages=(`cat -s apt-packages.txt | grep -v '#' | grep -v '^$'`)

for package in ${apt_package[@]}; do
    apt install ${package} -y --no-install-recommends
done
