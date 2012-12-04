# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
#ZSH_THEME="robbyrussell"
#ZSH_THEME="alanpeabody"
ZSH_THEME="idisagree"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment to change how many often would you like to wait before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git)

source $ZSH/oh-my-zsh.sh

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=30000
#setopt appendhistory

#custom
export EDITOR=vim
export TERM=xterm

alias sl="ls"
alias ll="ls -lh"
alias lla="ls -lha"
alias mkdir="mkdir -p"
alias grep="grep --color=tty"
# custom aliases
alias prettylog="awk '{print \$2,\"\t\",\$5,\$7,\$8,\$10,\$11}'"
alias proxyssh="ssh -N -D 0.0.0.0:12345 $1"
alias star_treck="play -c2 -n synth whitenoise band -n 100 24 band -n 300 100 gain +20"
alias nap_noise="play -t sl -r48000 -c2 - synth -1 pinknoise tremolo .1 40 <  /dev/zero"
alias ssh="( ssh-add -l > /dev/null || ssh-add ) && ssh"

# Add an "alert" alias for long running commands. Use like so:
# sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# alias codemod if exists
if [ -f ~/projects/codemod/src/codemod.py ]; then
    alias codemod="python ~/projects/codemod/src/codemod.py"
fi

# per machine conf
if [ -f $HOME/.private.rc ]; then
    source $HOME/.private.rc
fi

