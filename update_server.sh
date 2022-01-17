#!/bin/bash

FOLDER="steam_server"
SERVER_PATH="$PWD/$FOLDER"
echo "Try install to $SERVER_PATH"

/usr/sbin/steamcmd +login anonymous +force_install_dir $SERVER_PATH/ +app_update 4020 validate +quit 
