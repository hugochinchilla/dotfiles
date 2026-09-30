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

echo " - Installing system files (sudo)..."
sudo cp -r system/. /

echo " ✨ Success ✨"
