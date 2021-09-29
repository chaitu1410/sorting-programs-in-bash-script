m=0
for line in $(cat "numbers.txt")
do
        numbers[$m]="$line"
        m=$((m+1))
done

heapify() {
	local size=$1
	local i=$2
	largest=$i
	l=$(( (2*$i)+1 ))
	r=$(( (2*$i)+2 ))

	if (( $l<$size & numbers[$l]>numbers[$largest] )); then
		largest=$l
	fi

	if (( $r<$size & numbers[$r]>numbers[$largest] )); then
		largest=$r
	fi
	
	#if [[ $largest -ne $i ]]
	#then
	if (( $largest!=$i )); then
		tmp=${numbers[$i]}
		numbers[$i]=${numbers[$largest]}
		numbers[$largest]=$tmp
		heapify $size $largest
	fi
}

size=${#numbers[@]}
echo "Heap Sort Start"
echo

for (( i=($size/2)-1; i>=0; i-- )); do
        heapify $size $i
done

for (( i=$size-1; i>0; i-- )); do
        tmp=${numbers[0]}
        numbers[0]=${numbers[$i]}
        numbers[$i]=$tmp
        heapify $i 0
done

echo ${numbers[*]}

echo
echo "Heap Sort End"