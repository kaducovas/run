#!/bin/bash
logFileName=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | head -c 32)
cd $HOME/run && git pull origin master
cd $HOME/saphyra && git pull origin master
cd $HOME/run && python tuningScriptDocker.py > /volume/logs/${logFileName}.log
