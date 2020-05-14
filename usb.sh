#!/usr/bin/sh
# this file should be placed under /bin 

set -eu

ARGS="$@"

run() {
    local args="connected disconnected"
    local first_arg=${1:-}
    local command
    if [ -n "$first_arg" ] && [ ${first_arg} != -* ]; then
        command="$first_arg"
        for arg in $args; do
            if [ "$command" = "$arg" ]; then
                $arg "$arg"
            fi
        done
    else
        command="help"
        echo "No command given"
        echo
    fi

    if [ "${command}" = "help" ]; then
        help_msg ${command:-}
        exit 0
    fi

}

help_msg () {
    local command=${1:-}

    if [ -z "${command}" ] || [ "$command" = "help" ]; then
    echo "Usage: usb.sh [command] [signal]
Avaliable commands:
help
    display this help message

connected
    notify that the device was connected

disconnected
    notify that the device was disconnected"
    fi
}

connected () {
    local state=${1:-?}
    dunstify "device $state"
}

disconnected () {
    local state=${1:-?}
    dunstify "device $state"

}

run $ARGS

