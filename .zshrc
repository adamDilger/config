# Git branch in prompt.
parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

setopt PROMPT_SUBST
PROMPT='%F{blue}%n%f:%1~%F{green}$(parse_git_branch)%f%# '
# PROMPT='%9c%{%F{green}%}$(parse_git_branch)%{%F{none}%} $ '


# -- PATH --
# flutter
export PATH="$PATH:`pwd`/programs/flutter/bin"

# export PS1="\[\033[94m\]\u\[\033[00m\]:\W\\[\033[32m\]\$(parse_git_branch)\[\033[00m\]\$ "

#alias
alias ls="ls -lG"
alias grep="grep --color=auto"
alias gs="git status"
alias gt="git tree"
alias gto="git treeo"
alias json='python -mjson.tool'

#aurora
alias tmuxpayg="~/tmux_sessions/payg.sh"
alias aurorahealth="node ~/dev/aurorahealth/index.js"
alias aurora="~/scripts/aurora-login.sh"

alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

export EDITOR=vim

gc() { BRANCH=$(git branch | fzf --layout=reverse --height 40%); [ -z "$BRANCH" ] || git checkout $BRANCH; }

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
