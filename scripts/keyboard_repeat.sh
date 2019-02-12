#!/bin/bash


CURRENT=$(xfconf-query -c keyboards -p "/Default/KeyRepeat/Delay")

F_DELAY=164
F_RATE=79

S_DELAY=280
S_RATE=40


if [ $CURRENT != $F_DELAY ]; then
  xfconf-query -c keyboards -p "/Default/KeyRepeat/Delay" -s $F_DELAY
  xfconf-query -c keyboards -p "/Default/KeyRepeat/Rate" -s $F_RATE
  notify-send -t 1500 "Keyboard Repeat Change" "Changed to Normal"
else
  xfconf-query -c keyboards -p "/Default/KeyRepeat/Delay" -s $S_DELAY
  xfconf-query -c keyboards -p "/Default/KeyRepeat/Rate" -s $S_RATE
  notify-send -t 1500 "Keyboard Repeat Change" "Changed to Slow"
fi
