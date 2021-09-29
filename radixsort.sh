m=0
for line in $(cat "numbers.txt")
do
        numbers[$m]="$line"
        m=$((m+1))
done

i=0
max=0
size=${#numbers[@]}

for el in ${numbers[@]}
do
        if (( $el>$max ));
        then
                max=$el
        fi
done

declare -a oarr
declare -a carr 
exp=1
z=1
while (( ($max/$exp)>0 ));
do
        i=0
        while (( $i<10 ));
        do
                carr[i]=0
                i=$[$i+1]
        done

        i=0
        while (( $i<$size ));
        do
                k=$(((${numbers[i]}/$exp)%10))
                carr[k]=$[${carr[k]}+1]
                i=$[$i+1]
        done

        i=1
        while (( $i<10 ));
        do
                k=$[$i-1]
                carr[i]=$((${carr[i]}+${carr[k]}))
                i=$[$i+1]
        done


        i=$[$size-1]
        while (( $i>=0 ));
        do
                k=$(((${numbers[i]}/$exp)%10))
                oarr[$((${carr[k]}-1))]=${numbers[i]}
                carr[k]=$((${carr[k]}-1))
                i=$[$i-1]
        done
        
        for (( i=0; i<$size; i++ )); do
                numbers[i]=${oarr[i]}
        done

        z=$[$z+1]
        exp=$[$exp*10]
done

echo "Radix Sort Start"
echo
echo ${numbers[@]}
echo
echo "Radix Sort End"