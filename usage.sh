#!/bin/bash


TIMESTAMP=`cat /var/log/DOCKER_BUILD_TIME`


cat << EOF

williamyeh/redis - Docker image for Redis.
Image built at: $TIMESTAMP

Env
===

- Exported volumes:

    * [OUT] /data - for Redis persistent data.

    * [IN]  /etc/redis - for customized "redis.conf".


Usage
=====

## Starting a Redis server with my simple wrapper

  Cmd:  start  [config-file]
  Args:
    - config-file: default = redis.conf

  Examples:

    # start Redis server sliently with default configuration;
    # useful when '--link'ed with other containers
    $ docker run -d  --name redis  \\
        williamyeh/redis  start


    # start Redis server with public accessible TCP port
    $ docker run -d  --name redis  \\
        -p 6379:6379               \\
        williamyeh/redis  start


    # start Redis server with customized "redis.conf" from host OS
    $ docker run -d  --name redis            \\
        -p 6379:6379                         \\
        -v /myproject/conf/redis:/etc/redis  \\
        williamyeh/redis  start


    # start Redis server with customized conf filename from host OS
    $ docker run -d  --name redis            \\
        -p 6379:6379                         \\
        -v /myproject/conf/redis:/etc/redis  \\
        williamyeh/redis  start  redis-cluster.conf


    # start Redis server, with persistent data directory (creates dump.rdb)
    $ docker run -d  --name redis  \\
        -p 6379:6379               \\
        -v /myproject/data:/data   \\
        williamyeh/redis  start


## Connecting to existing Redis container with my simple wrapper

    # connect to Redis server named "redis"
    $ docker run -it --rm        \\
        --link redis:redis       \\
        williamyeh/redis  client


    # connect to an already-running Redis server named "mycache";
    # then give it an alias "redis" for client to refer to.
    $ docker run -it --rm        \\
        --link mycache:redis     \\
        williamyeh/redis  client


    # connect to Redis server named "redis";
    # then issue commands via redis-cli.
    $ docker run -it --rm        \\
        --link redis:redis       \\
        williamyeh/redis  client  info


## Benchmarking an existing Redis container with my simple wrapper

    # connect to Redis server named "redis"
    $ docker run --rm            \\
        --link redis:redis       \\
        williamyeh/redis  benchmark


    # connect to an already-running Redis server named "mycache";
    # then give it an alias "redis" for bechmark client to refer to.
    $ docker run --rm            \\
        --link mycache:redis     \\
        williamyeh/redis  benchmark



Usage: Official redis-* executables
===================================

If you'd like to invoke executables from official Redis distribution
for finer controls, you can call them directly.
They all reside in "/usr/local/bin" directory.


## Run official executable "redis-server"

  Cmd:  redis-server  [args]
  Args:
    [/path/to/redis.conf] [options]
    - (read config from stdin)
    -v or --version
    -h or --help
    --test-memory <megabytes>

  Examples:

    # start redis-server with password
    $ docker run -d  --name redis  \\
        williamyeh/redis           \\
        redis-server  /etc/redis/redis.conf  --requirepass <password>


## Run official executable "redis-cli"

    $ docker run -it --rm        \\
        --link redis:redis       \\
        williamyeh/redis         \\
        bash -c 'redis-cli -h \$REDIS_PORT_6379_TCP_ADDR'



EOF
