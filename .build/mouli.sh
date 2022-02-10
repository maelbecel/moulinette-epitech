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

bloc() {
    echo -e " $ORANGE$BOLD$UNDERLINE$1$DEFAULT\n"
}

end() {
    echo ""
    echo -e " \c"
    showbar $BLOC_PASSED $BLOC_TOTAL 20
    echo -e "\n ========================\n"
    BLOC_TOTAL=0
    BLOC_PASSED=0
    BLOC_FAILED=0
}

mouli() {
    TOTAL=$((TOTAL+1))
    BLOC_TOTAL=$((BLOC_TOTAL+1))
    echo -e "$BOLD    Test $BLOC_TOTAL :'$1' $DEFAULT"
    $2 > /dev/null
    retrn=$?
    if [ "$retrn" != "$4" ]; then
        FAILED=$((FAILED+1))
        BLOC_FAILED=$((BLOC_FAILED+1))
        echo -e "$BOLD$RED        [KO]$DEFAULT Bad return, need '$4' but have '$retrn'"
    else
        RES=$($2)
        if [ "$RES" = "$3" ]; then
            PASSED=$((PASSED+1))
            BLOC_PASSED=$((BLOC_PASSED+1))
            echo -e "$BOLD$GREEN        [OK]$DEFAULT Test PASSED"
        else
            FAILED=$((FAILED+1))
            BLOC_FAILED=$((BLOC_FAILED+1))
            echo -e "$BOLD$RED        [KO]$DEFAULT Bad output, need '$3' but have '$RES'"
        fi
    fi
    echo ""
}

displayres() {
    showbar $PASSED $TOTAL 33
    echo  ""
    echo -e "$PURPLE TOTAL $BOLD$TOTAL$DEFAULT |$GREEN PASSED $BOLD$PASSED$DEFAULT |$RED FAILED $BOLD$FAILED$DEFAULT"
    echo -e "$BOLD ====================================$DEFAULT"
}

############# INIT ##########

TOTAL=0
PASSED=0
FAILED=0

BLOC_TOTAL=0
BLOC_PASSED=0
BLOC_FAILED=0

make re > /dev/null
make clean > /dev/null

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

# mouli Test_name Command Resultat $?

eval $(cat tests/*.mouli)

############# Display #########

displayres
