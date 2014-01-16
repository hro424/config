#
# .zshrc
#

#
# COMPLETION
#

autoload -U compinit
compinit

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

case ${UID} in
  0)
    PROMPT="%B%{${fg[red]}%}%/#%{${reset_color}%}%b "
    PROMPT2="%B%{${fg[red]}%}%_#%{${reset_color}%}%b "
    [ -n "${REMOTEHOST}${SSH_CONNECTION}" ] &&
      PROMPT="%{${fg[red]}%}${HOST%%.*} ${PROMPT}"
    ;;
  *)
    PROMPT="%{${fg[magenta]}%}[%?]%{${reset_color}%} %* %{${fg[green]}%}[%~]%{${reset_color}%}"$'\n'"%m%B%%%b "
    RPROMPT="%{${fg[yellow]}%}%1v%{${reset_color}%}"
    PROMPT2="%{${fg[green]}%}%_%%%{${reset_color}%} "
    [ -n "${REMOTEHOST}${SSH_CONNECTION}" ] &&
    PROMPT="%{${fg_bold[magenta]}%}${PROMPT}"
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

#
# ALIASES
#

alias ls="ls -F --color"
alias la="ls -a"
alias ll="ls -al"

alias du="du -h"
alias df="df -h"

#
# ENVIRONMENT VARIABLES
#

export CONCURRENCY_LEVEL=8
export EDITOR=/usr/bin/vim
export MINICOM='-c on'
export GIT_PROXY_COMMAND=~/.git-proxy.sh
export GREP_OPTIONS="--color --exclude-dir=.svn --exclude-dir=.git"
export PATH=$PATH:~/bin
export PATH=$PATH:~/bin/ti-sdk-am335x-evm/linux-devkit/sysroots/i686-arago-linux/usr/bin
export PATH=$PATH:~/bin/depot_tools
export PATH=$PATH:~/bin/android-sdk-linux/platform-tools
export PATH=$PATH:~/bin/android-sdk-linux/tools
export PATH=$PATH:~/bin/android-ndk-r8c
export PATH=$PATH:~/.local/bin

export CPPUTEST_HOME=/usr/share/cpputest

#
# GIT COMPLETION
#

autoload bashcompinit
bashcompinit
source ~/.git-completion.sh

#
# Powerline
#
#source ~/.local/lib/python2.7/site-packages/powerline/bindings/zsh/powerline.zsh

# vim:sw=2:
