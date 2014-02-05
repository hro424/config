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

# GIT completion
zstyle ':completion:*:*:git:*' script ~/.git-completion.zsh

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
    PROMPT="$(command_result) %* %{${fg[green]}%}[%~]%{${reset_color}%}"$'\n'"%m%B%%%b "
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
config="$HOME/config/`uname`.alias.sh"
if [ -r $config ]; then
  . $config
fi

#
# ENVIRONMENT VARIABLES
#
config="$HOME/config/`uname`.env.sh"
if [ -r $config ]; then
  . $config
fi

#
# LOCAL SETTINGS
#
config="$HOME/.local.zshrc"
if [ -r $config ]; then
  . $config
fi

# vim:sw=2:

