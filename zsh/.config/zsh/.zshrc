#zmodload zsh/zprof

if [ "$DOTFILES_PROFILE_LOADED" != "1" ]; then
    source $HOME/.profile
fi

if [ -f $HOME/.zprofile ]; then
    source $HOME/.zprofile
fi

if [[ -n "$BYOBU_TTY" ]]; then
    # if already on a byobu window prevent new SSH connections from launching byobu if enabled by default on remote server
    export LC_BYOBU=0
fi

# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh
ZSH_CUSTOM=$XDG_CONFIG_HOME/zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="idisagree"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable bi-weekly auto-update checks
DISABLE_AUTO_UPDATE="true"

# Uncomment to change how many often would you like to wait before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(python virtualenvwrapper poetry-env)

# Load custom config
autoload bashcompinit
bashcompinit

source $HOME/.bash_aliases

source $ZSH/oh-my-zsh.sh

HISTFILE=$XDG_DATA_HOME/zsh/history
HISTSIZE=1000
SAVEHIST=3000

unsetopt correct_all
setopt correct
setopt rmstarsilent

autoload -U +X bashcompinit && bashcompinit

complete -o nospace -C /usr/local/bin/vault vault

source $HOME/.config/zsh/private/*

#zprof

