#
# .zshrc
#

#
# COMPLETION
#

autoload -Uz compinit promptinit
compinit
promptinit

# w/ colors
zstyle ':completion:*' list-colors ''

# case insensitive
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}'

#
# PROMPT
#

autoload colors
colors

# Let it understand escape sequence
setopt prompt_subst

# VCS info
autoload -Uz vcs_info
zstyle ':vcs_info:*' formats '[%b]%u%c'
#zstyle ':vcs_info:*' check-for-changes true

preexec() {
  print -Pn "\e]0;$1:%-5~\a"
}

precmd() {
  print -Pn "\e]0;%-5~\a"
  psvar=()
  vcs_info
  psvar[1]="$vcs_info_msg_0_"
}

command_result() {
  if [[ $? = 0 ]]; then
    echo "%{${fg[yellow]}%}:-)%{${reset_color}%}"
  else
    echo "%{${fg[red]}%}#-(%{${reset_color}%}"
  fi
}

case ${UID} in
  0)
    PROMPT="%B%{${fg[red]}%}%/#%{${reset_color}%}%b "
    PROMPT2="%B%{${fg[red]}%}%_#%{${reset_color}%}%b "
    [ -n "${REMOTEHOST}${SSH_CONNECTION}" ] &&
      PROMPT="%{${fg[red]}%}${HOST%%.*} ${PROMPT}"
    ;;
  *)
    PROMPT="$(command_result) %* %{${fg[green]}%}[%~]%{${reset_color}%}"$'\n'"%m%B%%%b "
    RPROMPT="%{${fg[yellow]}%}%1v%{${reset_color}%}"
    PROMPT2="%{${fg[green]}%}%_%%%{${reset_color}%} "
    [ -n "${REMOTEHOST}${SSH_CONNECTION}" ] &&
    PROMPT="%m $(command_result) %* %{${fg[green]}%}[%~]%{${reset_color}%}"$'\n'"%m%B%%%b "
    ;;
esac

#
# COMMAND HISTORY
#

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt hist_ignore_dups
setopt extended_history;

#
# KEY BINDING
#

# Emacs mode
bindkey -e

#
# OPTIONS
#

setopt auto_cd
setopt list_packed
setopt nolistbeep
setopt noautoremoveslash
setopt complete_aliases
setopt nonomatch
setopt extendedglob

#
# ALIASES
#

alias ls="ls -F --color"
alias la="ls -a"
alias ll="ls -al"

alias du="du -h"
alias df="df -h"

alias vi="vim"

#
# ENVIRONMENT VARIABLES
#

export CONCURRENCY_LEVEL=8
export EDITOR=/usr/bin/vim
export MINICOM='-c on'
export GREP_OPTIONS="--color --exclude-dir=.svn --exclude-dir=.git"

#
# ArchLinux Specific
#
source /usr/share/doc/pkgfile/command-not-found.zsh

# vim:sw=2:

