#!/bin/bash

# Author: Kelves C.
# Version: 0.6.0-beta (usable)
# License: Public Domain
# Description: 
# Search through the subtree of a directory where pdfs are stored
# and open the selected file in zathura

LIBRARIES=(/archv/papers)

while true;
do
    case $1 in
        cli)    PAPER=$(find ${LIBRARIES[@]} -type f -name *.pdf | fzy) ;;
        gui)    PAPER=$(find ${LIBRARIES[@]} -type f -name *.pdf | \
                        rofi -lines 15 -dmenu -p "read") ;;
    esac
    if [ -f "$PAPER" ];
    then
        # Initializes the pdfreader program
  	    zathura "$PAPER" &
        break
    elif [ ! -e "$PAPER" ];
    then
  	    exit 1
    else
    targetDir="$PAPER"
    fi
done
exit 0
