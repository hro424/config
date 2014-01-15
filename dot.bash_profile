alias ls='ls -FG'
alias la='ls -A'
alias ll='la -l'

export PAGER=less
export EDITOR=vim
export http_proxy="http://proxy.mei.co.jp:8080"
export https_proxy="http://proxy.mei.co.jp:8080"

[[ $PS1 && -f /usr/local/share/bash-completion/bash_completion.sh ]] && \
	source /usr/local/share/bash-completion/bash_completion.sh

source ~/.git-completion.bash
source ~/.git-prompt.sh

export GIT_PS1_SHOWDIRTYSTATE=1
export PS1="\`if [ \$? = 0 ]; then echo \[\e[33m\]:-\)\[\e[0m\]; else echo \[\e[31m\]#-\(\[\e[0m\]; fi\`"\
' [\t] \[\e[37m\]\w $(__git_ps1 "\[\e[32m\][%s]")\[\e[0m\]\n\$ '

