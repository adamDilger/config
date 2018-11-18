export ANDROID_HOME=/Users/$USER/Library/Android/sdk
export PATH=${PATH}:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools

# Git branch in prompt.
parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}
#export PS1="\u@\h \W\[\033[32m\]\$(parse_git_branch)\[\033[00m\] $ "
export PS1="\u:\W\[\033[32m\]\$(parse_git_branch)\[\033[00m\]$ "

#git autocomplete
[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion

#alias
alias ls="ls -lG"
alias grep="grep --color=auto"
alias gs="git status"
alias gb="git branch"
alias gdm="git diff master --stat"
alias json='python -mjson.tool'

#aurora
alias tmuxpayg="~/tmux_sessions/payg.sh"
alias aurora="~/Documents/aurora-login.sh"
defect() {
  git checkout -b "defect/APAYGAPP-$1"
}
alias config='/usr/bin/git --git-dir=/Users/work/.cfg/ --work-tree=/Users/work'
