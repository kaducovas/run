#!/bin/bash
cd $HOME/run && git pull origin master
cd $HOME/saphyra && git pull origin master
cd $HOME/run && ./teste.sh
