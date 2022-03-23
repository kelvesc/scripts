#!/usr/bin/env sh


while [ ! -z "${1}" ]; do

        echo "Editing "${1}""
        sed -i 's/$//' "${1}"
        #sed -i 's///g'
        #sed -i  's/\r//'
        #When we don't want to delete '\n'
        #sed -i ':a;N;$!ba;s/\n//g'

        if [ "${#}" -gt 0 ]; then
                shift
        fi
done

help(){
    cat << EOF Change Line Feed
A simple script to convert DOS linefeed to *NIX linefeed
Usage: chlf.sh input_file
EOF
}


### COPY OF CLEAN_TEXT JUST FOR A POSSIBLE MERGE ###

#convert () {
#    local file=${1:-}
#    local tmp_file
#    if [ -n "$file" ] && [ ${file} != -* ]; then
#        tmp_file=$(mktemp -t convert_file.XXXXX)
#        tr '\000' '\n' | sed 's/\r//' < $file > $tmp_file
#
#        cat $tmp_file > $file
#    fi
#}

# Other possible commands
#sed 's/.$//'
#sed 's/$//'
#sed 's///g'
#sed  's/\r//'
#sed ':a;N;$!ba;s/\n//g' # When we don't want to delete '\n'
#tr -d '\r'
#tr -d '\015'

