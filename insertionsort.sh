#!/bin/bash

m=0
for line in $(cat "numbers.txt")
do
        numbers[$m]="$line"
        m=$[$m+1]
done

size=${#numbers[@]}

echo "Insertion Sort Start"
echo

for (( i=1; i<size; i++ )); do
        key=${numbers[i]}
        j=$[$i-1]
        while (( $j>=0 & ${numbers[j]}>$key )); do
                numbers[j+1]=${numbers[j]}
                j=$[$j-1]
        done
        numbers[j+1]=$key
done
echo "${numbers[*]}"
echo
echo "Insertion Sort End"