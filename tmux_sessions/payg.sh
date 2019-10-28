#!/bin/sh
# cd ~/rxp/payg
# tmux new-session -s 'PAYG' -d
# tmux new-window
# tmux split-window -h
# tmux resize-pane -R 40
# tmux attach-session

#!/bin/sh
cd ~/rxp/payg/payg-fe
tmux new-session -s 'PAYG' \; \
  new-window \; \
  split-window -h \; \
  send-keys 'cd ResponsiveApp; clear' C-m \; \
  resize-pane -R 40 \; \
  new-session -s 'API' \; \
  send-keys 'cd ~/rxp/payg/payg-api; clear' C-m \; \
  attach-session -c ~/rxp/payg/payg-api \; \
  new-session -s 'DEV' \; \
  send-keys 'cd ~; clear' C-m \; \
  attach-session -c ~/ \; \
  new-session -s 'METHOD' \; \
  send-keys 'cd ~/rxp/methodcards/MethodCardsCore/ClientApp; clear' C-m \; \
  attach-session -c ~/rxp/methodcards/MethodCardsCore/ClientApp \; \
  new-session -s 'BF-API' \; \
  send-keys 'cd ~/rxp/betfair/betfair-api; clear' C-m \; \
  attach-session -c ~/rxp/betfair/betfair-api \; \
  new-session -s 'BETFAIR' \; \
  send-keys 'cd ~/rxp/betfair/betfair-fe; clear' C-m \; \
  attach-session -c ~/rxp/betfair/betfair-fe \; \
  new-window \; \
  split-window -h \; \
  resize-pane -R 40 \; \
  choose-tree -Zs;
