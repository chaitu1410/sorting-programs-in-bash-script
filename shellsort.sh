m=0
for line in $(cat "numbers.txt")
do
        numbers[$m]="$line"
        m=$((m+1))
done

size=${#numbers[@]}
gap=$(( size/2 ))

echo "Shell Sort Start"
echo
while (( gap>0 )); do
        for (( i=0,j=gap; j<size; i++,j++ )); do
                p=$i
                q=$j
                while (( numbers[q] < numbers[p] & p>=0 )); do
                        tmp=${numbers[p]}
                        numbers[p]=${numbers[q]}
                        numbers[q]=$tmp
                        p=$[$p-$gap]
                        q=$[$q-$gap]
                done
        done
        gap=$[$gap/2]
done
echo ${numbers[*]}
echo
echo "Shell Sort End"