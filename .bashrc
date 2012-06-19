# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
export HISTCONTROL=ignoredups

# append to the history file, don't overwrite it
shopt -s histappend

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

export HISTSIZE=1000
export HISTFILESIZE=2000


# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
xterm-color)
    PS1='${debian_chroot:+($debian_chroot)}\[\033[00;32m\]\u@\h\[\033[00m\]:\w\$ '
    ;;
*)
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
    ;;
esac

# Comment in the above and uncomment this below for a color prompt
PS1='${debian_chroot:+($debian_chroot)}\[\033[00;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD/$HOME/~}\007"'
    ;;
*)
    ;;
esac

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable color support of ls and also add handy aliases
if [ "$TERM" != "dumb" ]; then
    eval "`dircolors -b`"
    alias ls='ls --color=auto'
    #alias dir='ls --color=auto --format=vertical'
    #alias vdir='ls --color=auto --format=long'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll="ls -lh"
alias lla="ls -lha"

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

export EDITOR=vim
export TERM=xterm

# system command aliases
alias mkdir='mkdir -p'
alias grep='grep --color=tty'

# custom aliases
alias prettylog="awk '{print \$2,\"\t\",\$5,\$7,\$8,\$10,\$11}'"
alias proxyssh="ssh -N -D 0.0.0.0:12345 $1"
alias star_treck="play -c2 -n synth whitenoise band -n 100 24 band -n 300 100 gain +20"
alias nap_noise="play -t sl -r48000 -c2 - synth -1 pinknoise tremolo .1 40 <  /dev/zero"

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

# shortcuts for dns editting
if [ -f /etc/dnsmasq.conf ]; then
    alias dnse="sudo vim /etc/dnsmasq.conf"
    alias dnsr="sudo /etc/init.d/dnsmasq restart"
fi

if [ -f $HOME/.private.rc ]; then
    source $HOME/.private.rc
fi


        RED="\[\033[00;31m\]"
     YELLOW="\[\033[00;33m\]"
      GREEN="\[\033[00;32m\]"
       BLUE="\[\033[00;34m\]"
  LIGHT_RED="\[\033[01;31m\]"
LIGHT_GREEN="\[\033[01;32m\]"
      WHITE="\[\033[01;37m\]"
 LIGHT_GRAY="\[\033[00;37m\]"
 COLOR_NONE="\[\e[00m\]"

function parse_git_branch {
  git rev-parse --git-dir &> /dev/null
  git_status="$(git status 2> /dev/null)"
  branch_pattern="^# On branch ([^${IFS}]*)"
  detached_branch_pattern="# Not currently on any branch"
  remote_pattern="# Your branch is (.*) of"
  diverge_pattern="# Your branch and (.*) have diverged"
  if [[ ${git_status}} =~ "Changed but not updated" ]]; then
    state="${RED}⚡"
  fi
  # add an else if or two here if you want to get more specific
  if [[ ${git_status} =~ ${remote_pattern} ]]; then
    if [[ ${BASH_REMATCH[1]} == "ahead" ]]; then
      remote="${YELLOW}↑"
    else
      remote="${YELLOW}↓"
    fi
  fi
  if [[ ${git_status} =~ ${diverge_pattern} ]]; then
    remote="${YELLOW}↕"
  fi
  if [[ ${git_status} =~ ${branch_pattern} ]]; then
    branch=${BASH_REMATCH[1]}
  elif [[ ${git_status} =~ ${detached_branch_pattern} ]]; then
    branch="${YELLOW}NO BRANCH"
  fi

  if [[ ${#state} -gt "0" || ${#remote} -gt "0" ]]; then
    s=" "
  fi

  echo " ${branch}${s}${remote}${state}"
}

function prompt_func() {
  if [ $HOME == `pwd` ]; then
    # don't parse git branch for the $HOME git repository
    PS1=$PSAVE
    return
  fi
  git_dir=$(git rev-parse --git-dir)
  if [ $? -eq 0 ]; then
    #prompt="${TITLEBAR}${BLUE}[${RED}\W${GREEN}$(parse_git_branch)${BLUE}]${COLOR_NONE} "
    prompt="[as] ${debian_chroot:+($debian_chroot)}${GREEN}\u@\h${BLUE}:\w\$${COLOR_NONE} "
    PS1="${prompt}$ "
  else
    PS1=$PSAVE
  fi
}

#export PS1="${debian_chroot:+($debian_chroot)}${GREEN}\u@\h${BLUE}:\w\$${COLOR_NONE} "
#export PSAVE=$PS1

#PROMPT_COMMAND=prompt_func
