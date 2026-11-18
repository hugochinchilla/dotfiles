#!/bin/bash

echo " - Fetching submodules..."
git submodule update --init --recursive

echo " - Installing modules..."
cd dotfiles/
for MODULE in $(find . -maxdepth 1 -type d ! -name '.' -printf '%f\n'); do
    stow --adopt --target=$HOME $MODULE
    echo "  ⬤ $MODULE"
done
cd ..

echo " - Installing system packages (sudo)..."
sudo pacman -S --needed --noconfirm btrfsmaintenance

echo " - Installing system files (sudo)..."
sudo cp -r system/. /

if [ "$(findmnt -no FSTYPE /)" = "btrfs" ]; then
    echo " - Enabling btrfs maintenance timers (sudo)..."
    sudo systemctl enable --now btrfsmaintenance-refresh.path
    sudo systemctl start btrfsmaintenance-refresh.service
fi

echo " ✨ Success ✨"
