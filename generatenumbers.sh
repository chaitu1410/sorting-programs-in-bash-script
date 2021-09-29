#!/bin/bash

i=0
truncate -s 0 "numbers.txt"
if [ -z "$1" ]
then
        size=1000
else
        if (( $1<1 )); then
                size=1000
        else
                size=$1
        fi
fi

while [ $i -lt $size ]
do
	echo $RANDOM>>"numbers.txt"
	i=`expr $i + 1`
done

j=0
for line in $(cat "numbers.txt")
do
        numbers[$j]="$line"
        j=$((j+1))
done
echo "${numbers[*]}"
