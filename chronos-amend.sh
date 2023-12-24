#!/bin/bash

# datetime regex=[a-z]{3} [0-9]{4}-[0-9]{2}-[0-9]{2} [0-9]{2}:[0-9]{2}:
# 
LOG_FILE="./timelog.log"
DATE=$1
shift 1
TEXT=$@
FIND=$(date -d "$DATE" +"%Y-%m-%d %H:%M%%%s%%")
ENTRY_EXISTS=$(sed -n "/$FIND/p" $LOG_FILE);
if [ "$ENTRY_EXISTS" == "" ]; then
	echo "==> $ENTRY_EXISTS";
	echo "$(date -d "$DATE" +"%Y-%m-%d %H:%M%%%s")%$@" >> $LOG_FILE
else
	 sed -ri "s/($FIND).*$/\1$TEXT/" $LOG_FILE
fi
#sed "s/2023-11-29 12:00.*/2023-11-29 12:00%1701270000%Yupi! I was changed./"