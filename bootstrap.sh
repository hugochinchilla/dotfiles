#!/bin/bash

dir=$(realpath $(dirname ${BASH_SOURCE}))

git submodule init
git submodule update


if [ -f $HOME/.profile ]; then
  mv $HOME/.profile $HOME/.profile.bak
fi
ln -sf $dir/dotfiles/profile $HOME/.profile
ln -sf $dir/dotfiles/zprofile $HOME/.zprofile

source $HOME/.profile

mkdir -p $XDG_DATA_HOME
mkdir -p $XDG_DATA_HOME/zsh
mkdir -p $XDG_CACHE_HOME
mkdir -p $XDG_CACHE_HOME/vim/{undo,swap,backup}
mkdir -p $HOME/.npm-packages

cd dotfiles/
for MODULE in $(find . -maxdepth 1 -type d ! -name '.' -printf '%f\n'); do
    stow --adopt --target=$HOME $MODULE
done
cd ..


# Copy custom fonts
mkdir -p $HOME/.fonts
cp -r fonts/icomoon $HOME/.fonts
# Install powerline patched fonts and reset fc-cache
source fonts/powerline/install.sh

echo "Success"
