#!/bin/bash
#
# simple wrapper of "redis-cli"
#
# Usage:  client.sh  [redis-server-container-alias-name]
#
# Arguments:
#   - redis-server-container-alias-name: default="REDIS"
#

ARG_SERVER_ALIAS=${1:-REDIS}
NAME=${ARG_SERVER_ALIAS^^}   # to uppercase
#echo $NAME


ENV_SERVER_IP='$'$NAME'_PORT_6379_TCP_ADDR'
#echo $ENV_SERVER_IP
eval IP=$ENV_SERVER_IP


ENV_SERVER_PORT='$'$NAME'_PORT_6379_TCP_PORT'
#echo $ENV_SERVER_PORT
eval PORT=$ENV_SERVER_PORT


if [ -z "$IP" ]; then
    echo "Error: $ENV_SERVER_IP is empty"
    exit
elif [ -z "$PORT" ]; then
    echo "Error: $ENV_SERVER_PORT is empty"
    exit
fi


redis-cli  -h $IP  -p $PORT