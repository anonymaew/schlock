#!/bin/bash

date_format="%A, %d %B, %Y"

BOLD=$(tput bold)

print_clock () {
     digits=("⣰⠟⠻⣆" "⣿⣴⠟⣿" "⠹⣦⣴⠏")
    digits+=("⣴⢾⡇⠀" "⠀⢸⡇⠀" "⣤⣼⣧⣤")
    digits+=("⣴⠟⠻⣦" " ⢀⣴⠟" "⣴⣿⣥⣤")
    digits+=("⣴⠟⠻⣦" "⠀⠶⠾⣯" "⠻⣦⣴⠟")
    digits+=("⠀⣰⡟⠀" "⣰⡟⢰⡆" "⠛⠛⢻⡟")
    digits+=("⣼⠟⠛⠃" "⠿⠞⠻⣦" "⠻⣦⣴⠟")
    digits+=("⠀⣠⡾⠃" "⣼⠟⠻⣦" "⠻⣦⣴⠟")
    digits+=("⠛⠛⢻⡿" "⠀⢠⡿⠁" "⢠⡿⠁⠀")
    digits+=("⣴⠟⠻⣦" "⣽⠷⠾⣯" "⠻⣦⣴⠟")
    digits+=("⣴⠟⠻⣦" "⠻⣦⣴⡟" "⢠⡾⠋⠀")
    digits+=("⠀⢠⡄⠀" "⠀⠀⠀⠀" "⠀⠘⠃⠀")

    time=$(date +"%H:%M:%S")
    padding=$((WIDTH/2-${#time}*5/2))
    for line in {1..3}
    do
        printf "%${padding}s"
        for (( j=0; j<${#time}; j++ ))
        do
            if [ "${time:$j:1}" == ":" ]
            then
                offset=10*3+$line-1
            else
                offset=${time:$j:1}*3+$line-1
            fi
            echo -n "${BOLD}${digits[$offset]} "
        done
        echo
    done
}

print_date () {
    date=$(date +"$date_format")
    padding=$((WIDTH/2-${#date}/2))
    printf "%${padding}s"
    echo "${BOLD}$date"
    echo
}

cleanup () {
    printf "\033\143"
}

main () {
    cleanup
    WIDTH=$(tput cols)
    HEIGHT=$(tput lines)
    y_padding=$((HEIGHT/2-3))
    for (( i=0; i<$y_padding; i++ )); do echo; done

    print_date
    print_clock 

    tput civis
}

# loop and stop when any key is pressed
while true
do
    main
    read -t 1 -n 1
    if [ $? = 0 ]
    then
        cleanup
        exit 0
    fi
done
