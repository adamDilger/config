#!/bin/sh
# cd ~/rxp/payg
# tmux new-session -s 'PAYG' -d
# tmux new-window
# tmux split-window -h
# tmux resize-pane -R 40
# tmux attach-session

#!/bin/sh
cd ~/rxp/payg
tmux new-session -s 'PAYG' \; \
  new-window \; \
  split-window -h \; \
  send-keys 'cd ResponsiveApp; clear' C-m \; \
  resize-pane -R 40 \; \
  new-session -s 'API' \; \
  send-keys 'cd ~/rxp/payg-api; clear' C-m \; \
  attach-session -c ~/rxp/payg-api \; \
  new-session -s 'ADMIN' \; \
  send-keys 'cd ~/rxp/payg-admin; clear' C-m \; \
  attach-session -c ~/rxp/payg-admin \; \
  new-session -s 'BF-API' \; \
  send-keys 'cd ~/rxp/betfair-api; clear' C-m \; \
  attach-session -c ~/rxp/betfair-api \; \
  new-session -s 'BETFAIR' \; \
  send-keys 'cd ~/rxp/betfair; clear' C-m \; \
  attach-session -c ~/rxp/betfair \; \
  choose-tree -Zs \; \
