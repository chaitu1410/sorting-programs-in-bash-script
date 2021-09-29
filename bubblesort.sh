#!/bin/bash

m=0
for line in $(cat "numbers.txt")
do
        numbers[$m]="$line"
        m=$((m+1))
done
size=${#numbers[@]}



echo "Bubble Sort Start"

for (( p=0; p<size-1; p++ )); do
    for (( q=0; q<size-i-1; q++ )); do
        if (( numbers[q] > numbers[q+1] ));then
            tmp=${numbers[q]}
            numbers[q]=${numbers[q+1]}
            numbers[q+1]=$tmp
        fi
    done
done

echo "${numbers[*]}"
echo
echo "Bubble Sort End"