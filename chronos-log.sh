#!/bin/bash

# datetime regex=[a-z]{3} [0-9]{4}-[0-9]{2}-[0-9]{2} [0-9]{2}:[0-9]{2}:
# 

if [ "$1" == "--help" ]; then
	echo "Modo de uso: $0 [Grupo:] Título de la tarea realizada";
	exit;
fi

echo "$(date +"%Y-%m-%d %H:%M%%%s")%$@" >> ./timelog.log
