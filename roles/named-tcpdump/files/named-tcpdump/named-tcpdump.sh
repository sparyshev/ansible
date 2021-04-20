#!/bin/bash

source settings

function funcLogDir {
        mkdir -p $LOG_DIR && echo "$LOG_DIR has been created"
        touch $LOG_DIR$LOG_FILE && echo "$LOG_DIR$LOG_FILE has been created"
        chmod 777 $LOG_DIR$LOG_FILE && echo `ls -la $LOG_DIR$LOG_FILE`
}

function funcTcpdump {
        cmd=`$TCPDUMP_BIN $TCPDUMP_OPTIONS | grep -B 1 --line-buffered -E " A [0-9]" >> $LOG_DIR$LOG_FILE &`
        echo $cmd
}

if [ -e $LOG_DIR$LOG_FILE ]
        then
                funcTcpdump

        else
                funcLogDir
                funcTcpdump
fi
