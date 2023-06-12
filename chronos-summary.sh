#!/bin/bash
input="./timelog.log"
prev=0
curr=0
elapsed=0
totalhours=0
totalmins=0

pickedDate=$@
cat $input | grep "$pickedDate" > tmp.log
while IFS="%" read -r datetime timestamp task
do
    curr=$timestamp
    if [ $prev -lt 0 ]; then
        prev=$curr
    fi
    let "secs= ($curr - $prev)"
    let "mins= ($curr - $prev)/60"
    prev=$curr
    if [ "$task" == "Inicio" ]; then
        IFS=" " read -r day rest
        echo -e "\n==> $day <=="
    else
        echo "($mins mins) [$datetime] - $task"
    fi
done < ./tmp.log
rm ./tmp.log
