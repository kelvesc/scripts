#!/bin/bash

# Author: Kelves C.
# Version: 1.0.0
# License: Public Domain

set -e

ARGS="$@"

fail(){
        echo "ERROR: $@"
        exit 1
}

if ! command -v fzy; then
        fail "fzy not installed."
fi

if ! command -v rofi; then
        fail "rofi not installed."
fi

if ! command -v zathura; then
        fail "zathura not installed."
fi

readonly DEPENDENCIES="fzy rofi zathura"
_check_dependencies(){
        for dep in $DEPENDENCIES; do
                if ! command -v $dep; then
                        fail "$dep not installed."
                fi
        done
}

PDF_DIR=${2:"${HOME}/papers"}
if [[ -z $PDF_DIR ]]; then
        if [[ -d "${PDF_DIR}" ]]; then
                fail "directory ${PDF_DIR} does not exists."
        fi
fi

run(){
        case $1 in
                cli)    readonly menu=fzy ;;
                gui)    readonly menu="rofi -lines 15 -dmenu -p 'read' " ;;
        esac

        while true; do

                PDF_DIR=$(find ${PDF_DIR[@]} -type f -name *.pdf | "${menu}")

                if [ ! -e "$PDF_DIR" ]; then
                        fail "${PDF_DIR} does not exists."
                fi

                if [ -f "$PDF_DIR" ]; then
                        zathura "$PDF_DIR" &
                        break
                fi

        done

        exit 0
}

run "${ARGS}"
