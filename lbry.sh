#!/bin/bash

# Author: Kelves C.
# Version: 0.6.0-beta (usable)
# License: Public Domain
# Description:
# Search through the subtree of a directory where pdfs are stored
# and open the selected file in zathura

readonly LIBRARIES=(/archv/papers)

readonly QUERY="find ${LIBRARIES[@]} -type f -name *.pdf"

while true;
do
    case "$1" in
        cli)    PAPER=$( "${QUERY}" | fzy) ;;

        gui)    PAPER=$( "${QUERY}" | rofi -lines 15 -dmenu -p "read") ;;

    esac

    if [ -f "${PAPER}" ]; then
        # Initializes the pdfreader program
  	    zathura "${PAPER}" &
        break
    elif [ ! -e "${PAPER}" ]; then
  	    exit 1
    else
            # FIXME: what is targetDir?
            targetDir="${PAPER}"
    fi
done

exit 0
