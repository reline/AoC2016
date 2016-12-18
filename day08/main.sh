#!/usr/bin/env bash

x_size=50
y_size=6
size=$(( $x_size * y_size ))
declare -a SCREEN=( $(for i in {1..$size}; do echo 0; done) )

rect_regex='([0-9]+)x([0-9]+)'
rotate_regex='([0-9]+)'

function show_answer {
    answer_one=0

    for ((j = 0; j < $y_size; j++ )); do
        for ((i = 0; i < $x_size; i++ )); do
            d=$(( $x_size * $j + $i ))
            z=${SCREEN[$d]}
            if [ "$z" == "1" ]; then
                printf "#"
                ((answer_one+=1))
            else
                printf "."
            fi
        done
        echo
    done
    echo
    echo "$answer_one"
    echo
    echo
}

show_answer

function rect {
    echo "rect $1x$2"
    ((expected+=$1*$2))
    for ((j = 0; j < $2; j++ )); do
        for ((i = 0; i < $1; i++ )); do
            d=$(( $x_size * $j + $i ))
            SCREEN[$d]=1
        done
    done
}

function rotate_column {
    echo "rotate column x=$1 by $2"
    for (( k = 0; k < $2; k++)); do
        p=${SCREEN[$1]}
        for ((j = 1; j < $y_size; j++)); do
            d=$(( $x_size * $j + $1))
            t=${SCREEN[$d]}
            SCREEN[$d]=$p
            p=$t
        done
        SCREEN[$1]=$p
    done
}

function rotate_row {
    echo "rotate row y=$1 by $2"
    for (( k = 0; k < $2; k++)); do
        r=$(($1 * $x_size))
        p=${SCREEN[$r]}
        for ((j = 0; j < $x_size; j++)); do
            d=$(( $x_size * $1 + $j))
            t=${SCREEN[$d]}
            SCREEN[$d]=$p
            p=$t
        done
        SCREEN[$r]=$p
    done
}

while read f || [[ -n $f ]]; do
    clear
    a=$(echo $f | tr " " "\n")
    set ${a[0]}
    if [ "$1" == "rect" ]; then
        [[ "$2" =~ $rect_regex ]]
        rect "${BASH_REMATCH[1]}" "${BASH_REMATCH[2]}"
    else
        [[ "$3" =~ $rotate_regex ]]
        if [ "$2" == "column" ]; then
            rotate_column "${BASH_REMATCH[1]}" $5
        else
            rotate_row "${BASH_REMATCH[1]}" $5
        fi
    fi
    show_answer
    sleep .3s
done <puzzle_input.txt