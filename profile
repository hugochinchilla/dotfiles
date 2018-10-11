# vim: filetype=sh

## BEGIN XDG_CONFIG_SUPPORT

export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_HOME=$HOME/.local/share

### npm
export NPM_CONFIG_USERCONFIG=$XDG_CONFIG_HOME/npm/npmrc

### X11
export XINITRC="$XDG_CONFIG_HOME"/X11/xinitrc
export XSERVERRC="$XDG_CONFIG_HOME"/X11/xserverrc

### zsh
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"

### vim
export VIMINIT=":source $XDG_CONFIG_HOME"/vim/vimrc

## END XDG_CONFIG_SUPPORT

export EDITOR=vim
export LESSCHARSET=utf-8

# Python virtualenv
export WORKON_HOME="$HOME/.virtualenvs"

# Pulseaudio
export PULSE_RUNTIME_PATH="/run/user/$UID/pulse/"

# set PATH so it includes user's private bin if it exists
if [[ -d "$HOME/.bin" ]] ; then
  export PATH="$HOME/.bin:$PATH"
fi

if [[ -d "$HOME/.local/bin" ]] ; then
  export PATH="$HOME/.local/bin:$PATH"
fi

# Node global install without sudo
if [[ -d "$HOME/.npm-packages" ]] ; then
	export NPM_PACKAGES="${HOME}/.npm-packages"
	export PATH="$PATH:$NPM_PACKAGES/bin"

	# Unset manpath so we can inherit from /etc/manpath via the `manpath` command
	unset MANPATH # delete if you already modified MANPATH elsewhere in your config
	export MANPATH="$NPM_PACKAGES/share/man:$(manpath)"
fi

# Include composer packages in the path
if [[ -d "$HOME/.composer/vendor/bin" ]] ; then
  export PATH="$PATH:$HOME/.composer/vendor/bin"
fi

if [[ -f "$HOME/projects/stderred/build/libstderred.so" ]] ; then
  export LD_PRELOAD="$HOME/projects/stderred/build/libstderred.so${LD_PRELOAD:+:$LD_PRELOAD}"
fi

export DOTFILES_PROFILE_LOADED=1

# Load termite terminfo file
if [[ -f $XDG_CONFIG_HOME/termite/termite.terminfo ]] ; then
    tic -x $XDG_CONFIG_HOME/termite/termite.terminfo
fi
