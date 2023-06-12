#!/bin/bash

# datetime regex=[a-z]{3} [0-9]{4}-[0-9]{2}-[0-9]{2} [0-9]{2}:[0-9]{2}:
# 
DATE=$1
shift 1
echo "$(date -d "$DATE" +"%Y-%m-%d %H:%M%%%s")%$@" >> ./timelog.log