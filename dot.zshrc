#
# .zshrc
#

##############################################################################
# KEY BINDING
#

# Emacs mode
bindkey -e

#
# OPTIONS
#

setopt auto_cd
setopt auto_pushd
setopt pushd_ignore_dups
setopt ignore_eof
setopt no_flow_control
setopt list_packed
setopt nolistbeep
setopt noautoremoveslash
setopt complete_aliases
setopt nonomatch
setopt extendedglob
# Let it understand escape sequence
setopt prompt_subst

##############################################################################
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
zstyle ':completion:*:*:git:*' script ~/config/git-completion.zsh

# Menu selection
zstyle ':completion:*:default' menu select=2

##############################################################################
# PROMPT
#

autoload colors
colors

# VCS info
autoload -Uz vcs_info
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' stagedstr '+'
zstyle ':vcs_info:*' unstagedstr '-'
zstyle ':vcs_info:*' formats '[%b]%u%c'
zstyle ':vcs_info:*' actionformats '[%b|%a]%u%c'

preexec() {
  print -Pn "\e]0;$1:%-5~\a"
}

precmd() {
  print -Pn "\e]0;%-5~\a"
  psvar=()
  vcs_info
  psvar[1]="$vcs_info_msg_0_"
}

PR_SMILEY='%(?.%F{yellow}:-)%f.%F{red}#-()%f'
PR_CURRENT='%F{green}[%~]%f'

case ${UID} in
  # Super user
  0)
    PROMPT="%B%F{red}%/#%f%b "
    PROMPT2="%B%F{red}%_#%f%b "
    [ -n "${REMOTEHOST}${SSH_CONNECTION}" ] &&
      PROMPT="%F{red}${HOST%%.*} ${PROMPT}"
    ;;
  # Normal user
  *)
    PROMPT="$PR_SMILEY %* $PR_CURRENT"$'\n'"%m%B%%%b "
    RPROMPT="%F{yellow}%1v%f"
    PROMPT2="%F{green}%_%%%f "
    [ -n "${REMOTEHOST}${SSH_CONNECTION}" ] &&
    PROMPT="$PR_SMILEY %* $PR_CURRENT"$'\n'"%m%B%%%b "
    ;;
esac

##############################################################################
# COMMAND HISTORY
#

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt hist_ignore_dups
setopt extended_history;

##############################################################################
# ALIASES
#
config="$HOME/config/`uname`.alias.sh"
if [ -r $config ]; then
  . $config
fi

##############################################################################
# ENVIRONMENT VARIABLES
#
config="$HOME/config/`uname`.env.sh"
if [ -r $config ]; then
  . $config
fi

##############################################################################
# LOCAL SETTINGS
#
config="$HOME/.local.zshrc"
if [ -r $config ]; then
  . $config
fi

function zman() {
  PAGER="less -g -s '+/^ {7}"$1"'" man zshall
}

# vim:sw=2:

