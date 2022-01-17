#!/bin/bash

if [ $# -eq 0 ]
  then
    echo "Please set path to server install as parameter"
	exit -1
fi

SERVER_PATH=$1

steamcmd +login anonymous +force_install_dir $SERVER_PATH +app_update 4020 validate +quit
pause
