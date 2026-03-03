# If not running interactively, don't do anything (leave this at the top of this file)
[[ $- != *i* ]] && return

# All the default Omarchy aliases and functions
# (don't mess with these directly, just overwrite them here!)
source ~/.local/share/omarchy/default/bash/rc

# Add your own exports, aliases, and functions here.
#
# Make an alias for invoking commands you use constantly
# alias p='python'

alias rm="rm -I --preserve-root"
alias ll="ls -lh"
alias lla="ls -lha"
alias tailscale-personal-server-2="tailscale up --exit-node-allow-lan-access --exit-node=personal-server-2 --operator=$USER"
alias tailscale-reset="tailscale up --reset --operator=$USER"
alias anyformat="uv run anyformat"
alias h="uv run anyformat"

# ssh aliases
alias ssh-password='ssh -o PreferredAuthentications=password -o PubkeyAuthentication=no'
alias ssh="TERM=xterm-256color ssh"

alias mkdir='mkdir -p'
alias grep='grep --color=tty'
alias egrep='egrep --color=tty'

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

# Docker compose
alias dkill="docker compose kill"
alias dstop="docker compose stop"
alias drm="docker compose rm -f"
alias dps="docker compose ps"
alias dlogs="docker compose logs -f --tail=100"
alias drun="docker compose run --rm"
alias docker-bridge-ip="docker network inspect bridge --format='{{(index .IPAM.Config 0).Gateway}}'"
alias dip="docker-bridge-ip"

function dup() {
    docker compose up -d $@
}

function drestart() {
    dkill $@
    docker compose down $@
    dup $@
}

# Add an "alert" alias for long running commands. Use like so:
# sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

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

alias yay=yay --answerclean=All --answerdiff=None --answeredit=None
alias dark-mode="gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'"
alias light-mode="gsettings set org.gnome.desktop.interface color-scheme 'prefer-light'"


export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"

# Autojump
[[ -s /etc/profile.d/autojump.sh ]] && source /etc/profile.d/autojump.sh


# Load anyformat completion
[ -f "/home/hchinchilla/.local/share/bash-completion/completions/anyformat" ] && . "/home/hchinchilla/.local/share/bash-completion/completions/anyformat"

