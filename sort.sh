#!/bin/bash

a=0

while [ $a -lt 1000 ]
do
        numbers[$a]=$RANDOM
        a=`expr $a + 1`
done

#echo "${numbers[*]}"

#function sort(){
#	tmp=${numbers[$1]}
#    numbers[$1]=${numbers[$2]}
#    numbers[$2]=$tmp
#}

#sort 998 999

#echo "${numbers[*]}"


##################### Bubble Sort
function bubble_sort(){
	bubble=(${numbers[*]})
	size=${#bubble[@]}
	echo "Bubble Sort Start"
	for (( p=0; p<size-1; p++ )); do
		for (( q=0; q<size-i-1; q++ )); do
			if (( bubble[q] > bubble[q+1] ));then
				tmp=${bubble[q]}
				bubble[q]=${bubble[q+1]}
				bubble[q+1]=$tmp
			fi
		done
	done
	echo "${bubble[*]}"
	echo "Bubble Sort End"
	echo
	echo
}

# bubble_sort

##################### Selection Sort
function selection_sort(){
	selection=(${numbers[*]})
	size=${#selection[@]}
	echo "Selection Sort Start"
	for (( p=0; p<size-1; p++ )); do
		t=$p
		for (( q=p+1; q<size; q++ )); do
			if (( selection[q] < selection[t] ));then
				t=$q
			fi
		done
		tmp=${selection[t]}
		selection[t]=${selection[p]}
		selection[p]=$tmp
	done
	echo "${selection[*]}"
	echo "Selection Sort End"
	echo
	echo
}

#selection_sort

##################### Insertion Sort
function insertion_sort(){
	insertion=(${numbers[*]})
	size=${#insertion[@]}
	echo "Insertion Sort Start"
	for (( p=1; p<size; p++ )); do
		key=${insertion[p]}
		q=$(expr $p - 1)
		while (( $q>=0 & ${insertion[q]}>$key )); do
			insertion[q+1]=${insertion[q]}
			q=$(expr $q - 1)
		done
		insertion[q+1]=$key
	done
	echo "${insertion[*]}"
	echo "Insertion Sort End"
	echo
	echo
}

#insertion_sort

####################### Merge Sort

merge() {
	local first=2
	local second=$(( $1 + 2 ))
	for i in ${@:2}
	do
		if [[ $first -eq $(( $1 + 2 )) ]]
		then
			echo ${@:$second:1} ; ((second += 1))
		else
			if [[ $second -eq $(( ${#@} + 1 )) ]]
			then
				echo ${@:$first:1} ; ((first += 1))
			else
				if [[ ${@:$first:1} -lt ${@:$second:1} ]]
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
	if [[ $1 -ge 2 ]]
	then
		local med=$(( $1 / 2 ))
		local first=( $(mergesort $med ${@:2:$med}) )
		local second=( $(mergesort $(( $1 - $med )) ${@:$(( $med + 2 )):$(( $1 - $med ))}) )
		echo $(merge $med ${first[@]} ${second[@]})
	else
		echo $2
	fi
}

merge_sort_function(){
	merge_n=(${numbers[*]})
	echo "Merge Sort Start"
	echo $(mergesort 1000 ${merge_n[@]})
	echo "Merge Sort End"	
}

#merge_sort_function

############### Quick Sort

#quick_n=(${numbers[*]})

swap() {
  local tmp=${quick_n[$1]}
  quick_n[$1]=${quick_n[$2]}
  quick_n[$2]=$tmp
}

quicksort() {
  local st=$1
  local end=$2

  if (( $st != $end )); then
    local sep=$st
    
    for ((i=st+1; i<end; i++)); do
      if ((quick_n[i] < quick_n[st])); then
        swap $((++sep)) $i
      fi
    done

    swap $st $sep
    quicksort $st $sep
    quicksort $((sep + 1)) $end
  fi
}

q_sort_fn(){
	size=${#quick_n[@]}
	echo "Quick Sort Start"
	quicksort 0 $size
	echo "${quick_n[*]}"
	echo "Quick Sort End"
}

#q_sort_fn

####################radix sort

radix_sort(){
	radix=(${numbers[*]})
	size=${#radix[@]}
	i=0
	max=0
	
	echo "Radix Sort Start"
	
	for el in ${radix[@]}
	do
		if [ $el -gt $max ]
		then
			max=$el
		fi
	done
	echo "Max element is found!!!: ${max}"

	declare -a oarr
	declare -a carr 
	exp=1
	z=1
	while [ $(($max/$exp)) -gt 0 ]
	do
		i=0
		while [ $i -lt 10 ]
		do
			carr[i]=0
			i=$[$i+1]
		done

		i=0
		while [ $i -lt $size ]
		do
			k=$(((${radix[i]}/$exp)%10))
			carr[k]=$[${carr[k]}+1]
			i=$[$i+1]
		done

		i=1
		while [ $i -lt 10 ]
		do
			k=$[$i-1]
			carr[i]=$((${carr[i]}+${carr[k]}))
			i=$[$i+1]
		done


		i=$[$size-1]
		while [ $i -ge 0 ]
		do
			k=$(((${radix[i]}/$exp)%10))
			oarr[$((${carr[k]}-1))]=${radix[i]}
			carr[k]=$((${carr[k]}-1))
			i=$[$i-1]
		done
		
		for (( i=0; i<$size; i++ )); do
			radix[i]=${oarr[i]}
		done

		z=$[$z+1]
		exp=$[$exp*10]
	done

	echo "Printing final sorted array"
	echo ${radix[@]}
	echo "Radix Sort End"
}


#################### Shell sort

shell_sort() {
	shell=(${numbers[*]})
	size=${#shell[@]}
	gap=$(( size/2 ))
	echo "Shell Sort Start"
	while (( gap>0 )); do
		for (( i=0,j=gap; j<size; i++,j++ )); do
			p=$i
			q=$j
			while (( shell[q] < shell[p] & p>=0 )); do
				tmp=${shell[p]}
				shell[p]=${shell[q]}
				shell[q]=$tmp
				p=$[$p-$gap]
				q=$[$q-$gap]
			done
		done
		gap=$[$gap/2]
	done
	echo ${shell[*]}
	echo "Shell Sort End"
}
#shell_sort


heap=(${numbers[*]})

heapify() {
	local n=$1
	local i=$2
	largest=$i
	l=$(( (2*$i)+1 ))
	r=$(( (2*$i)+2 ))

	if (( $l<$n & heap[$l]>heap[$largest] )); then
		largest=$l
	fi

	if (( $r<$n & heap[$r]>heap[$largest] )); then
		largest=$r
	fi
	
	#if [[ $largest -ne $i ]]
	#then
	if (( $largest!=$i )); then
		tmp=${heap[$i]}
		heap[$i]=${heap[$largest]}
		heap[$largest]=$tmp
		heapify $n $largest
	fi
}

heap_sort(){
	n=${#heap[@]}
	echo "Heap Sort Start"
	for (( i=($n/2)-1; i>=0; i-- )); do
		heapify $n $i
	done

	for (( i=$n-1; i>0; i-- )); do
		tmp=${heap[0]}
		heap[0]=${heap[$i]}
		heap[$i]=$tmp
		heapify $i 0
	done

	echo ${heap[*]}
	echo "Heap Sort End"
}

#heap_sort


# merge(){
#         local start=$1
#         local mid=$2
#         local end=$3

#         p=$start
#         q=$(( mid+1 ))
#         k=0

#         for (( i=start;i<=end;i++ )); do

#                  if (( p>mid  )); then
#                         array[k]=${numbers[q]}
#                         k=$(( k+1 ))
#                         q=$(( q+1 ))
#                 elif (( q>end )); then
#                         array[k]=${numbers[p]}
#                         k=$(( k+1 ))
#                         p=$(( p+1 ))

#                 elif (( numbers[p]<numbers[q] )); then
#                         array[k]=${numbers[p]}
#                         k=$(( k+1 ))
#                         p=$(( p+1 ))
#                 else
#                         array[k]=${numbers[q]}
#                         k=$(( k+1 ))
#                         q=$(( q+1 ))
#                 fi
#         done

#         for (( c=0;c<k;c++ )); do
#                 numbers[start]=${array[c]}
#                 start=$(( start+1 ))
#         done
# }

# mergesort() {
#         local start=$1
#         local end=$2

#         if (( start<end )); then
#                 mid=$(( (start+end)/2 ))

#                 mergesort $start $mid
#                 mergesort $(( mid+1 )) $end

#                 merge $start $mid $end
#         fi
# }

# size=${#numbers[@]}
# echo "Merge Sort Start"
# echo

# mergesort 0 $(( size-1 ))
# echo "${numbers[*]}"

# echo
# echo "Merge Sort End"	


# n1=$(( $m-$l+1 ))
        # n2=$(( $r-$m ))

        # declare -a LArr
	# declare -a RArr 

        # for (( i=0; i<$n1; i++ )); do
        #         t=$(( $l+$i ))
        #         LArr[$i]=${numbers[$t]}
        # done

        # for (( j=0; j<$n2; j++ )); do
        #         t=$(( $m+$j+1 ))
        #         RArr[$j]=${numbers[$t]}
        # done

        # i=0
        # j=0
        # k=$l

        # while (( $i<$n1 & $j<$n2 )); do
        #         if (( LArr[$i]<=RArr[$j]  )); then
        #                 numbers[$k]=${LArr[$i]}
        #                 i=$(( i+1 ))
        #         else
        #                 numbers[$k]=${RArr[$j]}
        #                 j=$(( j+1 ))
        #         fi
        #         k=$(( k+1 ))
        # done

        # while (( $i<$n1 )); do
        #         numbers[$k]=${LArr[$i]}
        #         i=$(( i+1 ))
        #         k=$(( k+1 ))
        # done

        # while (( $j<$n2 )); do
        #         numbers[$k]=${RArr[$j]}
        #         j=$(( j+1 ))
        #         k=$(( k+1 ))
        # done