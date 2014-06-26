#!/bin/bash
#
# simple wrapper of redis-server
#
# Usage:  start.sh  [config-filename]
#
# Arguments:
#   - config-filename: default="redis.conf"
#

CONF=${1:-redis.conf}

redis-server  /etc/redis/$CONF