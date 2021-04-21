#!/bin/bash

source settings

function funcLogDir {
        mkdir -p $LOG_DIR && echo "$LOG_DIR has been created"
        touch $LOG_DIR$LOG_FILE && echo "$LOG_DIR$LOG_FILE has been created"
        chmod 777 $LOG_DIR$LOG_FILE && echo `ls -la $LOG_DIR$LOG_FILE`
}

function funcTcpdump {
        cmd=`$TCPDUMP_BIN $TCPDUMP_OPTIONS | egrep --line-buffered -e "\+\sA\?" -e "[0-9]{1,2}\/13\/[0-9]{1,2}\sA\s([0-9]{1,3}[\.]){3}[0-9]{1,3}" >> $LOG_DIR$LOG_FILE &`
        echo $cmd
}

if [ -e $LOG_DIR$LOG_FILE ]
        then
                funcTcpdump

        else
                funcLogDir
                funcTcpdump
fi
