m=0
for line in $(cat "numbers.txt")
do
        numbers[$m]="$line"
        m=$((m+1))
done


swap() {
  local tmp=${numbers[$1]}
  numbers[$1]=${numbers[$2]}
  numbers[$2]=$tmp
}

quicksort() {
  local st=$1
  local end=$2

  if (( $st != $end )); then
    local sep=$st
    
    for ((i=st+1; i<end; i++)); do
      if ((numbers[i] < numbers[st])); then
        swap $((++sep)) $i
      fi
    done

    swap $st $sep
    quicksort $st $sep
    quicksort $((sep + 1)) $end
  fi
}


size=${#numbers[@]}
echo "Quick Sort Start"
echo
quicksort 0 $size
echo "${numbers[*]}"
echo
echo "Quick Sort End"