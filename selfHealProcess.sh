#!/bin/bash

#1. input process name to track
#2. input file to use to restart process
#3. if process stopped, try to restart it.
#4. if restart fails, page and sleep for 10mins.

# usage: setsid selfHealProcess.sh <maxwell> <identifier> "<command to run>"  >/data/process-monitoring/selfHealProcess.log 2>&1 < /dev/null &

p_name=$1
key_name=$2
f_name=$3
e_count=0
LOG_FILE=/data/process-monitoring/selfheal-$1-$2.log

while :
do
    count=$(ps aux|grep -i "$1"|grep "$2"|grep -v grep|grep -v "nohup"|grep -vi "selfheal"|wc -l)
    zero=0
    echo "p_count:$count" >> $LOG_FILE
    echo "e_count:$e_count" >> $LOG_FILE
    if  [ $count -eq $zero ];
    then
        if [ $e_count -gt 2 ]; then
            echo "[ERROR] for $1.$2" >> $LOG_FILE            
            sleep 60
        fi

        e_count=$((e_count+1))
        echo "restarting process ${3}" >> $LOG_FILE
        setsid $3 >> $LOG_FILE 2>&1 < /dev/null &
    fi
    sleep 60
done
echo "exiting"