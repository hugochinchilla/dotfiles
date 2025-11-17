#!/bin/bash

dir=$(realpath $(dirname ${BASH_SOURCE}))

# Install xterm-termite terminal support
tic -x termite.terminfo

git submodule init
git submodule update


if [ -f $HOME/.profile ]; then
  mv $HOME/.profile $HOME/.profile.bak
fi
ln -sf $dir/profile $HOME/.profile
ln -sf $dir/zprofile $HOME/.zprofile

source $HOME/.profile

mkdir -p $XDG_DATA_HOME
mkdir -p $XDG_DATA_HOME/zsh
mkdir -p $XDG_CACHE_HOME
mkdir -p $XDG_CACHE_HOME/vim/{undo,swap,backup}
mkdir -p $HOME/.npm-packages

for MODULE in $(find $dir -maxdepth 1 -type d ! -name '.*' -printf '%f\n'); do
  [[ $MODULE != 'dotfiles' ]] \
    && [[ $MODULE != 'fonts' ]] \
    && [[ $MODULE != 'assets' ]] \
    && [[ $MODULE != 'scripts' ]] \
    && stow --adopt $MODULE
done


# Copy custom fonts
mkdir -p $HOME/.fonts
cp -r fonts/icomoon $HOME/.fonts
# Install powerline patched fonts and reset fc-cache
source fonts/powerline/install.sh

echo "Success"
