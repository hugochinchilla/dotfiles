if [ -d $HOME/.composer/vendor/bin ]; then
    export PATH=$PATH:$HOME/.composer/vendor/bin
fi

export EDITOR=vim
export TERM=xterm

alias ll="ls -lh"
alias lla="ls -lha"


# system command aliases
alias mkdir='mkdir -p'
alias grep='grep --color=tty'

# custom aliases
alias sudo="sudo -E" # preserve environment by default
alias prettylog="awk '{print \$2,\"\t\",\$5\"]\",\$7,\$10,\$8,\$11}'"
alias proxyssh="ssh -N -D 0.0.0.0:12345 $1"
alias star_treck="play -c2 -n synth whitenoise band -n 100 24 band -n 300 100 gain +20"
alias nap_noise="play -t sl -r48000 -c2 - synth -1 pinknoise tremolo .1 40 <  /dev/zero"
alias updick='/usr/bin/uptime | perl -ne "/(\d+) d/;print 8,q(=)x\$1,\"D\n\""'
alias brightness="xrandr --output DVI-I-1 --brightness $1"
alias vi="vim"

# Vagrant
alias vssh="vagrant ssh"
alias vs="vssh"
alias vup="vagrant up"
alias vst="vagrant status"

# Git
alias gp="git pull --rebase"
alias gps="git push"
alias gs="git status"
alias gg="git grep -in"
alias gd="git diff"

# Add an "alert" alias for long running commands. Use like so:
# sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'


# load git-achievemnts if available
#if [ -f ~/projects/git-achievements ]; then
#    export PATH="$PATH:~/projects/git-achievements"
#fi
#if ( type git-achievements &> /dev/null ); then
#    alias git="git-achievements"
#fi

# alias codemod if exists
if [ -f ~/projects/codemod/src/codemod.py ]; then
    alias codemod="python ~/projects/codemod/src/codemod.py"
fi

if [ -f ~/.local_aliases ]; then
    . ~/.local_aliases
fi

