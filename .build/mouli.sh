#!/bin/bash

BOLD="\e[1m"
UNDERLINE="\e[4m"
DEFAULT="\e[0m"
PURPLE="\e[49;36m"
GREEN="\e[49;92m"
RED="\e[49;91m"
ORANGE="\e[49;93m"

print_banned() {
    for file in "$1"/* ; do
        if [[ ! -z $(grep -in ' printf(' $file) ]]; then
            echo -e "$RED$BOLD[$file\c"
            grep -in ' printf(' $file | awk -F: '{printf ":L"$1"]"}'
            echo -e "$DEFAULT$BOLD : printf() function banned.$DEFAULT"
        fi
        if [[ ! -z $(grep -in ' strlen(' $file) ]]; then
            echo -e "$RED$BOLD[$file\c"
            grep -in ' strlen(' $file | awk -F: '{printf ":L"$1"]"}'
            echo -e "$DEFAULT$BOLD : strlen() function banned.$DEFAULT"
        fi
        if [[ ! -z $(grep -in ' strcat(' $file) ]]; then
            echo -e "$RED$BOLD[$file\c"
            grep -in ' strcat(' $file | awk -F: '{printf ":L"$1"]"}'
            echo -e "$DEFAULT$BOLD : strcat() function banned.$DEFAULT"
        fi
    done
}

showbar() {
    have=$1
    on=$2
    len=$3

    percentage=$((have*100/on))
    valid=$((percentage*len/100))
    invalid=$((len-valid))
    echo -e " $GREEN\c"
    perl -E "print '█' x $valid"
    echo -e "$DEFAULT$RED\c"
    perl -E "print '█' x $invalid"
    echo -e " $DEFAULT$BOLD$percentage$DEFAULT%"
}


############# INIT ##########


if [ "$1" = "-n" ]; then
    NORME=$(normez -i)
    echo -e "\n ========================"
    echo -e "$ORANGE$BOLD$UNDERLINE"
    echo -e "Norme:$DEFAULT\n"
    if [ -z "$NORME" ]; then
        echo -e "$BOLD$GREEN\c"
        echo -e "No faults$DEFAULT"
    else
        normez -i
    fi
fi

if [ "$1" = "-b" ]; then
    echo -e "\n ========================"
    echo -e "$ORANGE$BOLD$UNDERLINE"
    echo -e "Norme:$DEFAULT\n"
    bubulle -ii -ic -f
fi

BANNEDSRC=$(cat src/*  | grep -e ' printf(' -e ' strlen(' -e ' strcat(')
BANNEDLIB=$(cat lib/my/*  | grep -e ' printf(' -e ' strlen(' -e ' strcat(')
echo -e "\n ========================"
echo -e "$ORANGE$BOLD$UNDERLINE"
echo -e "Banned functions:$DEFAULT\n"
if [ -z "$BANNEDSRC" ] && [ -z "$BANNEDLIB" ]; then
    echo -e "$BOLD$GREEN\c"
    echo -e "No banned function used$DEFAULT"
else
    print_banned "src"
    print_banned "lib/my"
fi
echo -e "\n ========================\n"

############# Tests ##########

if [[ ! -z $(ls -alf tests/ | grep ".unit") ]]; then
    echo -e "\n        $BOLD========================$DEFAULT"
    echo -e "        $PURPLE$BOLD      $UNDERLINE Units tests. $DEFAULT"
    echo -e "        $BOLD========================$DEFAULT"
    ./unit
fi

if [[ ! -z $(ls -alf tests/ | grep ".fonc") ]]; then
    echo -e "\n        $BOLD========================$DEFAULT"
    echo -e "        $PURPLE$BOLD  $UNDERLINE Fonctionnal tests. $DEFAULT"
    echo -e "        $BOLD========================$DEFAULT"
    ./fonc
fi

