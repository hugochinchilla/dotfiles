if [ -d $HOME/.composer/vendor/bin ]; then
    export PATH=$PATH:$HOME/.composer/vendor/bin
fi

export EDITOR=vim
export TERM=xterm
export PATH="$PATH:$HOME/.bin"


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
alias resource="source ~/.zshrc"

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
alias grc="git rebase --continue"
alias grs="git rebase --skip"
alias gra="git rebase --abort"
alias ga="git commit --amend"

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

# Work aliases
alias hab="cd $HOME/projects/habitissimo"
alias cc="hab && php symfony cc && notify-send -i edit-clear \"symfony cache cleared\""
alias vag="cd $HOME/projects/vagrantfiles"
alias habshell="hab && phpsh symfony-interactive.php"
alias runworker="hab && php symfony worker:run"
alias runworker-email="hab && php symfony worker:run SendMailWorkerThread"
alias sqlyog="wine .wine/drive_c/Program\ Files\ \(x86\)/SQLyog/SQLyog.exe"
alias mytop="watch -n 0,2 'mysql -uroot -px2kh5424 -e \"show processlist\"'"
alias adsl="sudo ip ro del default && sudo ip ro add default via 192.168.1.8 dev eth0 && ip ro"
alias fibber="sudo ip ro del default && sudo ip ro add default via 192.168.1.4 dev eth0 && ip ro"

if [ -f ~/.local_aliases ]; then
    . ~/.local_aliases
fi

