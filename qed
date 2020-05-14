#!/usr/bin/sh

# QED: quick edit for the main config file
# Version: 0.3

ARGS="$@"

PROGS="sxhkd bspwm mksh nvim"

set -eu

run() {
    local first_arg="${1:-help}"
    local command
    if [ -n "$first_arg" ] && [ ${first_arg} != -* ]; then
        command="$first_arg"
        for prog in $PROGS; do
            if [ "$prog" = "$command" ]; then
                echo $command
                case "$command" in
                    "nvim")   file=$HOME/.config/nvim/init.vim ;;
                    "bspwm")  file=$HOME/.config/bspwm/bspwmrc ;;
                    "sxhkd")  file=$HOME/.config/sxhkd/sxhkdrc ;;
                    "mksh")   file=$HOME/.mkshrc ;;
                     *)     exit 1 ;;
                esac
                exec sakura -x "nvim "$file"" 2> /dev/null &
                exit 0
            fi
        done
        echo ">>> Unknown command "$command""
        display_help
        exit 1

    else
        command="help"
        echo "No command given"
        echo
    fi

    if [ "${command}" = "help" ] || $(hasflag "--help -h"); then
        display_help ${command:-}
        exit 0
    fi

}

display_help() {
    local command=${1:-}

    if [ -z "${command}" ] || [ "$command" = "help" ]; then
        cat << EOF
Usage: qed.sh <config_file>

Quick edit configuration file

Commands:
EOF
        printf "    %-15s %s\n" "help" "Prints this help message"
    else
        echo "Options for $command:"
    fi

    cat << EOF

Global Options:

    -h --help       Prints this help message
EOF

}

hasflag() {
    local flags="$@"
    for var in $ARGS; do
        for flag in $flags; do
            if [ "$var" = "$flag" ]; then
                echo "true"
                return
            fi
        done
    done
    unset var
    echo "false"
}

# Read the value of a option passed as argument
readopt() {
    local opts="$@"
    for var in $ARGS; do
        for opt in $opts; do
            if [ "$var" = ${opt} ]; then
                local val="${var##${opt}}"
                if [ "$val" != "$var" ]; then
                    echo $val
                    return
                fi
            fi
        done
    done
    echo
}

run $ARGS

