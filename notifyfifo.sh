#!/usr/bin/env sh

trap 'rm "$PIPE"' 10

PIPE="/tmp/PIPE"

check_if_fifo_exists ()
{
    [ -p $PIPE ] || mkfifo "$PIPE"
}

notify_to_fifo ()
{
    if check_if_fifo_exists; then 
        # this message doesn't really matters for now
        echo "device_connected" >> "$PIPE"
    fi
}

notify_to_fifo

rm "$PIPE"

