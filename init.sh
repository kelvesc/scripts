#!/bin/sh

# Author: Kelves C.
# Version: 0.9.8
# License: Public Domain
# Description:
# Wrap up script to start a set of programs when X starts

## Mouse and Keyboard
kblayout.sh 2>&1 1> $(mktemp -t kblayout.sh.log.XXX) &
setsid xsetroot -cursor_name left_ptr &
[ $(pidof -xs xbanish) ] || setsid xbanish &

## Desktop Environment
dps.sh 2>&1 1> $(mktemp -t dps.sh.log.XXX) &
[ $(pidof -xs randomize-bg) ] || \
(kill $(pidof -x randomize-bg) 2>&1 1> /dev/null || \
randomize-bg 2>&1 1> $(mktemp -t wall.log.XXX) &)

picom --config=$XDG_CONFIG_HOME/picom/picom.conf \
    2> $(mktemp -t compton.log.XXX) &
picomPID=$!

while ! ps -hp $picomPID > /dev/null;do
    sleep 1
done
unset $Pid_of_Compton
xrdb $HOME/.Xresources 2>&1 1> $(mktemp -t xrdb.log.XXX)
bar 2>&1 1> $(mktemp -t bar.log.XXX) &
[ $(pidof -xs conky) ] || conky 2>&1 1> $(mktemp -t conky.log.XXX) &

## URxvtd
[ ! $(pidof -xs urxvtd) ] && urxvtd -q -o -f &

exit 0

