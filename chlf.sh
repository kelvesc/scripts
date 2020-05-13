#!/bin/sh

ARGS="$@"

#  to display these Ctrled characters on text

#sed 's/.$//'
#sed 's/$//'
#sed 's///g'
#sed  's/\r//'

# Whe we don't want to delete '\n'
#sed ':a;N;$!ba;s/\n//g'

#TODO: Improve this piece of shit and implemente options
#tr -d '\r'
#tr -d '\015'

description () {
    echo "Change Line Feed
A simple script to convert DOS linefeed to *NIX linefeed"
}

help() {
    echo "Usage: chlf.sh < input_file"
}

convert () {
    #TODO: test with a actual file (temp file) and a file descriptor
    #local args
    local file=${1:-}
    local tmp_file
    if [ -n "$file" ] && [ ${file} != -* ]; then
        tmp_file=$(mktemp -t convert_file.XXXXX)
        tr -d '\015' < $file > $tmp_file
        cat $tmp_file > $file
    fi
}

loop_args () {
    local target_files=$ARGS
    if [ -n "$target_files" ] && [ ${target_files} != -* ]; then
        for file in $target_files; do
            convert $file
        done
    else
        echo "No file given"
        echo
        help ${1:-}
        exit 0
    fi
}

loop_args $ARGS
