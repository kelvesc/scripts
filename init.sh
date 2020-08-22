#!/bin/sh

# Author: Kelves C.
# Version: 0.9.8
# License: Public Domain
# Description:
# Wrap up script to start a set of programs when X starts

## redirect both stdout and stderr to a logfile
exec 1> $(mktemp -t init.log.XXX) 2>&1

## Mouse and Keyboard
kblayout.sh &
setsid xsetroot -cursor_name left_ptr &
[ $(pidof -xs xbanish) ] || setsid xbanish &

## Desktop Environment
dps.sh &
[ $(pidof -xs randomize-bg) ] || \
(kill $(pidof -xs randomize-bg) || \
randomize-bg &)

xrdb -quiet -load $HOME/.Xresources; \
bar &

picom -b --config=$XDG_CONFIG_HOME/picom/picom.conf; \
    [ $(pidof -xs conky) ] || conky &

## URxvtd
[ ! $(pidof -xs urxvtd) ] && urxvtd -q -o -f &

exit 0

