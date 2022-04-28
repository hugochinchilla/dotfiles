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


export PATH="$HOME/.bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$PATH:$HOME/.npm-packages/bin"
export PATH="$PATH:$HOME/.config/composer/vendor/bin"

for gem_bin_dir in $HOME/.local/share/gem/ruby/*/bin; do
  export PATH="$PATH:$gem_bin_dir"
done

if [[ -f "$HOME/projects/stderred/build/libstderred.so" ]] ; then
  export LD_PRELOAD="$HOME/projects/stderred/build/libstderred.so${LD_PRELOAD:+:$LD_PRELOAD}"
fi

if [ -f ~/.ssh/agent.env ] ; then
    . ~/.ssh/agent.env > /dev/null
    if ! kill -0 $SSH_AGENT_PID > /dev/null 2>&1; then
        echo "Stale agent file found. Spawning a new agent. "
        eval `ssh-agent | tee ~/.ssh/agent.env`
        ssh-add
    fi
else
    echo "Starting ssh-agent"
    eval `ssh-agent | tee ~/.ssh/agent.env`
    ssh-add
fi


export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

export DOTFILES_PROFILE_LOADED=1
