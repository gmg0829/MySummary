#!/bin/sh
APP_NAME=metabase.jar
PID=`ps -ef | grep java  |grep $APP_NAME |awk '{print $2}'`
echo "find metabase PID:$PID"
kill -9 $PID
echo "killed metabase PID:$PID"
./start.sh
echo "start success!"