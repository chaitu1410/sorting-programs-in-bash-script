m=0
for line in $(cat "numbers.txt")
do
        numbers[$m]="$line"
        m=$((m+1))
done

merge() {
	local first=2
	local second=$(( $1 + 2 ))
	for i in ${@:2}
	do
		if (( $first == ( $1 + 2 ) ))
		then
			echo ${@:$second:1} ; ((second += 1))
		else
			if (( $second == ( ${#@} + 1 ) ))
			then
				echo ${@:$first:1} ; ((first += 1))
			else
				if (( ${@:$first:1} < ${@:$second:1} ))
				then
					echo ${@:$first:1} ; ((first += 1))
				else
					echo ${@:$second:1} ; ((second += 1))
				fi
			fi
		fi
	done
}

mergesort() {
	if (( $1 >= 2 ))
	then
		local med=$(( $1 / 2 ))
		local first=( $(mergesort $med ${@:2:$med}) )
		local second=( $(mergesort $(( $1 - $med )) ${@:$(( $med + 2 )):$(( $1 - $med ))}) )
		echo $(merge $med ${first[@]} ${second[@]})
	else
		echo $2
	fi
}

size=${#numbers[*]}
echo "Merge Sort Start"
echo
echo $(mergesort $size ${numbers[*]})
echo
echo "Merge Sort End"