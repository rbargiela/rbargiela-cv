#!/bin/bash

# datetime regex=[a-z]{3} [0-9]{4}-[0-9]{2}-[0-9]{2} [0-9]{2}:[0-9]{2}:
# 

echo "$(date +"%Y-%m-%d %H:%M%%%s")%$@" >> ./timelog.log