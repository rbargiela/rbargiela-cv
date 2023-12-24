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
        if [ "$pickedDate" == "" ]; then
            printSubTotals
        fi
        IFS=" " read -r day rest <<< $datetime
        echo -e "\n==> $(date -d "$day" +"%a") $day <=="
    else
        let "secs=$mins*60"
        hr=$(date -d@$secs -u +%H:%M)
        echo "($mins mins - $hr hs) [$datetime] - $task"
    fi
}

function calculateTotalmins(){
    if [ "$task" == "Inicio" ]; then
        let "totalmins=0"
        let "nothing=0"
    else
        let "totalmins=$totalmins+$mins"
    fi
    let "secs=$totalmins*60"
    hours=$(date -d@$secs -u +%H:%M)
}


function calculateSubTotalmins(){
    if [ "$task" == "Inicio" ]; then
        let "subtotalmins=0"
    else
        let "subtotalmins=$subtotalmins+$mins"
    fi
    let "subsecs=$subtotalmins*60"
    hourssubtotal=$(date -d@$subsecs -u +%H:%M)
}

function printTotals(){
    echo -e "\n[Total: ($totalmins mins) $hours h]"
}

function printSubTotals(){
    echo -e "\n[SubTotal: ($subtotalmins mins) $hourssubtotal h]"
}

init $@
while IFS="%" read -r datetime timestamp task
do
    calculateTaskTime
    calculateTotalmins
    printResume
    calculateSubTotalmins
done < ./tmp.log;rm ./tmp.log
printTotals