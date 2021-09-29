#!/bin/bash

i=0

#while [ $i -lt 1000 ]
#do
#	echo $RANDOM>>"numbers.txt"
#	i=`expr $i + 1`
#done

#echo "${numbers[*]}"
#export numbers=$numbers


j=0
for line in $(cat "numbers.txt")
do
        numbers[$j]="$line"
        j=$((j+1))
done
echo "${numbers[*]}"