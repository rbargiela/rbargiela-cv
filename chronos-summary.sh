#!/bin/bash

function init(){
    input="./timelog.log"
    prev=0;curr=0;elapsed=0
    pickedDate=$@; cat $input | grep "$pickedDate" > tmp.log
}

function calculateTaskTime(){
    curr=$timestamp
    if [ $prev -lt 0 ]; then
        prev=$curr
    fi
    let "mins= ($curr - $prev)/60";
    return $mins;
}

function printResume(){
    prev=$curr
    if [ "$task" == "Inicio" ]; then
        IFS=" " read -r day rest <<< $datetime
        echo -e "\n==> $(date -d "$day" +"%a") $day <=="
    else
        echo "($mins mins) [$datetime] - $task"
    fi
}

function calculateTotalmins(){
    if [ "$task" == "Inicio" ]; then
        let "totalmins=0"
    else
        let "totalmins=$totalmins+$mins"
    fi
    hours=$(bc <<< "scale=2; $totalmins/60")
}

function printTotals(){
    echo -e "\n[Total: ($totalmins mins) $hours h]"
}

init $@
while IFS="%" read -r datetime timestamp task
do
    calculateTaskTime
    calculateTotalmins
    printResume
done < ./tmp.log;rm ./tmp.log
printTotals