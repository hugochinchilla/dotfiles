# If not running interactively, don't do anything (leave this at the top of this file)
[[ $- != *i* ]] && return

# Incoming ssh sessions on these hosts land straight in tmux (attach if one is running).
# The interactive guard above keeps scp/rsync/git-over-ssh out of this.
if [[ -n $SSH_TTY && -z $TMUX && ${HOSTNAME%%.*} =~ ^(archer|ip-10-0-0-10)$ ]] && command -v tmux >/dev/null; then
  exec tmux new -A -s main
fi

# All the default Omarchy aliases and functions
# (don't mess with these directly, just overwrite them here!)
if [ -f "~/.local/share/omarchy/default/bash/rc" ]; then
  source ~/.local/share/omarchy/default/bash/rc
fi

export PATH="/home/hchinchilla/.local/bin:$PATH"
export PATH="$PATH:/home/hchinchilla/.local/share/gem/ruby/3.4.0/bin"
export PATH="$PATH:/home/hchinchilla/.cargo/bin"

# Add your own exports, aliases, and functions here.
#
# Make an alias for invoking commands you use constantly
# alias p='python'

alias rm="rm -I --preserve-root"
alias ll="ls -lh"
alias lla="ls -lha"
alias tailscale-personal-server-2="tailscale up --exit-node-allow-lan-access --exit-node=personal-server-2 --operator=$USER"
alias tailscale-reset="tailscale up --reset --operator=$USER"
alias anyformat="uv run af"
alias af="uv run af"
alias h="uv run anyformat"

# ssh aliases
alias ssh-password='ssh -o PreferredAuthentications=password -o PubkeyAuthentication=no'
ssh() {
  # -o options replicate ghostty's ssh-env integration (disabled in ghostty config
  # so this function isn't clobbered by ghostty's own ssh() wrapper)
  TERM=xterm-256color command ssh \
    -o "SetEnv COLORTERM=truecolor" \
    -o "SendEnv TERM_PROGRAM TERM_PROGRAM_VERSION" "$@"
}

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
alias kctx="kubectx"
alias kns="kubens"
alias k="kubectl"

alias yay=yay --answerclean=All --answerdiff=None --answeredit=None
alias dark-mode="gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'"
alias light-mode="gsettings set org.gnome.desktop.interface color-scheme 'prefer-light'"
alias cocaine="systemd-inhibit --what=handle-lid-switch --who='me' --why='keep awake on lid close' --mode=block sleep infinity"


export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"

# Autojump
[[ -s /etc/profile.d/autojump.sh ]] && source /etc/profile.d/autojump.sh


# Load anyformat completion
[ -f "/home/hchinchilla/.local/share/bash-completion/completions/anyformat" ] && . "/home/hchinchilla/.local/share/bash-completion/completions/anyformat"

# Fix crackling sound when CPU is bussy
alias better-sound="pw-metadata -n settings 0 clock.force-quantum 2048"
# Load af completion
[ -f "/home/hchinchilla/.local/share/bash-completion/completions/af" ] && . "/home/hchinchilla/.local/share/bash-completion/completions/af"
# lean-ctx shell hook — begin
export LEAN_CTX_SHELL_ACTIVATION=agents-only  # only wrap shells under an agent, not my interactive shells
if [ -f "/home/hchinchilla/.config/lean-ctx/shell-hook.bash" ]; then
. "/home/hchinchilla/.config/lean-ctx/shell-hook.bash"
fi
# lean-ctx shell hook — end

# >>> lean-ctx agent aliases >>>
alias claude='LEAN_CTX_AGENT=1 BASH_ENV="$HOME/.bashenv" claude'
alias codebuddy='LEAN_CTX_AGENT=1 BASH_ENV="$HOME/.bashenv" codebuddy'
alias codex='LEAN_CTX_AGENT=1 BASH_ENV="$HOME/.bashenv" codex'
alias gemini='LEAN_CTX_AGENT=1 BASH_ENV="$HOME/.bashenv" gemini'
# <<< lean-ctx agent aliases <<<


