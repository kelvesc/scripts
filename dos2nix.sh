#!/bin/env sh

# Simple script to convert DOS linefeed to *NIX linefeed

# Usage: dos2nix.sh < input_file > output_file

#  to display these Ctrled characters on text

#sed 's/$//'
#sed 's///g'

# Whe we don't want to delete '\n'
#sed ':a;N;$!ba;s/\n//g'

# This one below just tries to delete the CR
#sed -e 's/.$//'

#TODO: Imporve this piece of shit
tr -d '\r'
#tr -d '\015'

