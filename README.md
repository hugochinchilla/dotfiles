# Dotfiles

## Installation

Warning this snippet is provided for my own use, use it with caution.

```
# remove previous dotfiles repo if exists
rm -rf ~/.git

# remove previous installation of oh-my-zsh
rm -rf ~/.oh-my-zsh 

git clone https://github.com/hugochinchilla/dotfiles.git ~/dotfiles
cd ~/dotfiles
./bootstrap.sh
```


## HiDPI settings with swayland and Xwayland

Installed aur/sway-hidpi-git

Followed instructions in https://github.com/swaywm/wlroots/pull/2064#issuecomment-622647075
