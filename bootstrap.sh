#!/bin/bash

dir=$(realpath $(dirname ${BASH_SOURCE}))

if [ -f $HOME/.profile ]; then
  mv $HOME/.profile $HOME/.profile.bak
fi
ln -sf $dir/profile $HOME/.profile

source $HOME/.profile

mkdir -p $XDG_DATA_HOME
mkdir -p $XDG_CACHE_HOME
mkdir -p $XDG_CACHE_HOME/vim/{undo,swap,backup}
mkdir -p $HOME/.npm-packages

for MODULE in $(find $dir -maxdepth 1 -type d ! -name '.*' -printf '%f\n'); do
  [[ $MODULE != 'dotfiles' ]] \
    && [[ $MODULE != 'fonts' ]] \
    && stow --adopt $MODULE
done

source fonts/install.sh

echo "Success"
