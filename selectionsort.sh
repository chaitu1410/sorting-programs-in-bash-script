#!/bin/bash

m=0
for line in $(cat "numbers.txt")
do
        numbers[$m]="$line"
        m=$((m+1))
done

size=${#numbers[@]}

echo "Selection Sort Start"

for (( p=0; p<size-1; p++ )); do
    t=$p
    for (( q=p+1; q<size; q++ )); do
        if (( numbers[q] < numbers[t] ));then
            t=$q
        fi
    done
    tmp=${numbers[t]}
    numbers[t]=${numbers[p]}
    numbers[p]=$tmp
done
echo "${numbers[*]}"
echo
echo "Selection Sort End"