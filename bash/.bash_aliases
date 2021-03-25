alias ll="ls -lh"
alias lla="ls -lha"

# ssh aliases
alias ssh-password='ssh -o PreferredAuthentications=password -o PubkeyAuthentication=no'
alias ssh="TERM=xterm-256color ssh"

# system command aliases
alias mkdir='mkdir -p'
alias grep='grep --color=tty'
alias egrep='egrep --color=tty'

# custom aliases
alias sudo="sudo -E " # preserve environment by default
alias proxyssh="ssh -N -D 0.0.0.0:12345 $1"
alias updick='/usr/bin/uptime | perl -ne "/(\d+) d/;print 8,q(=)x\$1,\"D\n\""'
alias brightness="xrandr --output DVI-I-1 --brightness $1"
alias vi="vim"
alias todo="vim ~/TODO"
alias htop="TERM=screen htop"
alias xclip="xclip -selection clipboard"

# alias cal to ncal if ncal exists
if command -v ncal > /dev/null 2 >& 1; then
    alias cal='ncal -Mb'
fi

# Git
alias git="LANGUAGE=C LC_ALL=en_US.utf-8 git"
alias got="git "
alias gp="git pull --rebase"
alias gps="git push"
alias gs="git status"
alias gd="git diff"
alias grc="git rebase --continue"
alias grs="git rebase --skip"
alias gra="git rebase --abort"
alias ga="git commit --amend"

# parses output from git grep and opens files on sublime
function gosub(){
      awk '{print $1}' | sed 's/:$//' | xargs subl
}

# Add an "alert" alias for long running commands. Use like so:
# sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# alias codemod if exists
if [ -f ~/projects/codemod/src/codemod.py ]; then
    alias codemod="python ~/projects/codemod/src/codemod.py"
fi

function ban_ip() {
    iptables -A INPUT -s $1 -j DROP
}

# Docker compose
alias dkill="docker-compose kill"
alias dstop="docker-compose stop"
alias drm="docker-compose rm -f"
alias dps="docker-compose ps"
alias dlogs="docker-compose logs -f -t --tail=1000"
alias dl="dlogs"
alias drun="docker-compose run --rm"

function dup() {
    docker-compose up -d $@
}

function drestart() {
    dstop $@
    drm $@
    dup $@
    dnotify "Docker-compose restarted"
}

function dbash() {
    local CONTAINER_NAME=$1
    local COMPOSE_CONTAINER=`dps 2> /dev/null | awk '{print $1}' | grep $1`

    if [ -n "$COMPOSE_CONTAINER" ]; then
        local CONTAINER_NAME=$COMPOSE_CONTAINER
    fi

    docker exec -it $CONTAINER_NAME bash -c "TERM=xterm bash"
}

# Arch aliases
alias pkg-install="pacman -S"
alias pkg-search="pacman -Ss"
alias pkg-remove="pacman -Rs"
alias pkg-purge="pacman -Rsn"
alias pkg-update="pacman -Sy"
alias pkg-upgrade="pacman -Syu"
alias pkg-list="pacman -Q"

# Kubectl aliases
alias k=kubectl
alias kg="kubectl get"
alias kd="kubectl describe"
alias ke="kubectl edit"
alias kns=kubens
alias kctx=kubectx

alias yays=yay --answerclean=All --answerdiff=None --answeredit=None
