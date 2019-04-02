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

#escape map
setxkbmap -option caps:escape

#git autocomplete
[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion

#alias
alias ls="ls -l --color=auto"
alias grep="grep --color=auto"
alias gs="git status"
alias gt="git tree"
alias gto="git treeo"
alias json='python -mjson.tool'

#aurora
alias tmuxpayg="~/tmux_sessions/payg.sh"
alias aurorahealth="node ~/dev/aurorahealth/index.js"
alias aurora="~/scripts/aurora-login.sh"
defect() {
  git checkout -b "defect/APAYGAPP-$1"
}

alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

export PATH="/usr/local/bin/:/usr/local/opt/curl/bin:$PATH"
export EDITOR=vim

#FZF
# need to work out how to use layout=normal in vim
# export FZF_DEFAULT_OPTS="--layout=reverse --height 40%"
notes() { FILE=$(\ls "$HOME/notes/" | fzf --layout=reverse --height 40% --preview "head -100 $HOME/notes/{}"); [ -z "$FILE" ] || vim "$HOME/notes/$FILE"; }
gc() { BRANCH=$(git branch | fzf --layout=reverse --height 40%); [ -z "$BRANCH" ] || git checkout $BRANCH; }

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
