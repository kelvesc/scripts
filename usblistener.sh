#!/usr/bin/sh
# this file should be placed under /bin 

trap 'rm "$PIPE"' 10

PIPE="/tmp/PIPE"

check_if_fifo_exists ()
{
    [ -p "$PIPE" ] || mkfifo "$PIPE"
}

listen_to_fifo ()
{
    while true; do
        check_if_fifo_exists && SIGNAL=$(cat "$PIPE")
        [ $SIGNAL == "" ] && dunstify "$SIGNAL"
        sleep .5
    done
}

listen_to_fifo

