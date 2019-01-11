# How to Install

alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

config config --local status.showUntrackedFiles no

git clone --bare https://github.com/adamDilger/config.git .cfg
