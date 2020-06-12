# export ANDROID_HOME=/Users/$USER/Library/Android/sdk
export ANDROID_HOME=/android/android-sdk
export PATH=${PATH}:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools:$ANDROID_HOME/emulator:$ANDROID_HOME/emulator

# Git branch in prompt.
parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

#color        \[\033[32m\]

export PS1="\[\033[94m\]\u\[\033[00m\]:\W\\[\033[32m\]\$(parse_git_branch)\[\033[00m\]\$ "

#bash history (unlimited)
HISTSIZE=
HISTFILESIZE=

#tty fixes for vim
stty -ixon

#git autocomplete
[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion

#alias
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
  alias ls="ls -l --color=auto"
  alias grep="grep --color=auto"
elif [[ "$OSTYPE" == "darwin"* ]]; then
  alias ls="ls -lG"
fi

alias gs="git status"
alias gt="git log --graph --decorate --oneline --all "
alias gto="git log --graph --decorate --oneline"
alias json='python -mjson.tool'

alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

export EDITOR=vim

# DEVICE SPECIFIC CONFIG
[ -f ~/.device_bashrc ] && source ~/.device_bashrc;

#FZF
# need to work out how to use layout=normal in vim
# export FZF_DEFAULT_OPTS="--layout=reverse --height 40%"
gc() { BRANCH=$(git branch | fzf --layout=reverse --height 40%); [ -z "$BRANCH" ] || git checkout $BRANCH; }

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
