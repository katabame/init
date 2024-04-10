#!/usr/bin/bash

sudo apt-get install -y --no-install-recommends \
    meson wget build-essential ninja-build cmake-extras cmake \
    gettext gettext-base fontconfig libfontconfig-dev libffi-dev libxml2-dev \
    libxkbcommon-x11-dev libxkbregistry-dev libxkbcommon-dev libpixman-1-dev \
    libudev-dev libseat-dev seatd libxcb-dri3-dev libvulkan-dev libvulkan-volk-dev \
    vulkan-validationlayers-dev libvkfft-dev libgulkan-dev libegl-dev libgles2 \
    libegl1-mesa-dev glslang-tools libinput-bin libinput-dev libxcb-composite0-dev \
    libavutil-dev libavcodec-dev libavformat-dev libxcb-ewmh2 libxcb-ewmh-dev \
    libxcb-present-dev libxcb-icccm4-dev libxcb-render-util0-dev libxcb-res0-dev \
    libxcb-xinput-dev libpango1.0-dev xdg-desktop-portal-wlr hwdata \
    libcairo2-dev libzip-dev librsvg2-dev libgbm-dev jq git

mkdir ~/HyprSource
cd ~/HyprSource

## Clone sources

# hyprland
git clone https://github.com/hyprwm/Hyprland.git

# hyprlang
git clone https://github.com/hyprwm/hyprlang.git

# hyprcursor
git clone https://github.com/hyprwm/hyprcursor.git

# wayland
git clone https://gitlab.freedesktop.org/wayland/wayland.git

# wayland-protocols
git clone https://gitlab.freedesktop.org/wayland/wayland-protocols.git

# libdisplay-info
git clone https://gitlab.freedesktop.org/emersion/libdisplay-info.git

# tomlplusplus
git clone https://github.com/marzer/tomlplusplus.git

# libdrm
git clone https://gitlab.freedesktop.org/mesa/drm.git


## Build dependencies

# wayland
cd ~/HyprSource/wayland
mkdir ./build &&
cd    ./build &&
meson setup ..            \
      --prefix=/usr       \
      --buildtype=release \
      -Ddocumentation=false &&
ninja
sudo ninja install

# wayland-protocols
cd ~/HyprSource/wayland-protocols
mkdir ./build &&
cd    ./build &&
meson setup --prefix=/usr --buildtype=release &&
ninja
sudo ninja install

# libdisplay-info
cd ~/HyprSource/libdisplay-info
mkdir ./build &&
cd    ./build &&
meson setup --prefix=/usr --buildtype=release &&
ninja
sudo ninja install

# tomlplusplus
cd ~/HyprSource/tomlplusplus
mkdir ./build &&
cd    ./build &&
meson setup --prefix=/usr --buildtype=release &&
ninja
sudo ninja install

# libdrm
cd ~/HyprSource/drm
mkdir ./build &&
cd    ./build &&
meson setup --prefix=/usr --buildtype=release &&
ninja
sudo ninja install

# hyprlang
cd ~/HyprSource/hyprlang
cmake --no-warn-unused-cli -DCMAKE_BUILD_TYPE:STRING=Release -DCMAKE_INSTALL_PREFIX:PATH=/usr -S . -B ./build
cmake --build ./build --config Release --target hyprlang -j`nproc 2>/dev/null || getconf NPROCESSORS_CONF`
sudo cmake --install ./build

# hyprcursor
cd ~/HyprSource/hyprcursor
cmake --no-warn-unused-cli -DCMAKE_BUILD_TYPE:STRING=Release -DCMAKE_INSTALL_PREFIX:PATH=/usr -S . -B ./build
cmake --build ./build --config Release --target all -j`nproc 2>/dev/null || getconf NPROCESSORS_CONF`
sudo cmake --install ./build

# hyprland
cd ~/HyprSource/Hyprland
sed -i 's/\/usr\/local/\/usr/g' Makefile
mkdir ./build &&
cd    ./build &&
meson setup --prefix=/usr --buildtype=release &&
ninja
sudo ninja install

## back to home directory
cd ~

echo -e "\e[30m NOW YOU HAVE HYPRLAND INSTALLED!!! \e[0m"
