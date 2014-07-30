Docker-Redis
============

## Summary

Repository name in Docker Hub: **[williamyeh/redis](https://registry.hub.docker.com/u/williamyeh/redis/)**

This repository contains Dockerized [Redis](http://redis.io/), published to the public [Docker Hub](https://registry.hub.docker.com/) via **automated build** mechanism.



## Configuration

This docker image contains the following software stack:

- OS: Debian jessie (built from [debian:jessie](https://registry.hub.docker.com/_/debian/)).

- Redis


### Dependencies

- [debian:jessie](https://registry.hub.docker.com/_/debian/).


### History

- 0.2 - Add more convenient wrappers (`usage.sh`, `start.sh`, `client.sh`).

- 0.1 - This repository was forked from [dockerfile/redis](https://github.com/dockerfile/redis). 


## Why yet another Redis image for Docker?

There has been quite a few Redis images for Docker (e.g., [search](https://registry.hub.docker.com/search?q=redis) in the Docker Hub), so why reinvent the wheel?

In the beginning I used the [dockerfile/redis](https://github.com/dockerfile/redis). It worked well, but left some room for improvement:

- *Base OS image* - It was built from [dockerfile/ubuntu](https://registry.hub.docker.com/u/dockerfile/ubuntu/), which may not be the smallest one.  On the other hand, [debian:jessie](https://registry.hub.docker.com/_/debian/), as recommended in this [article](http://crosbymichael.com/dockerfile-best-practices-take-2.html), worth a try.

- *Unnecessary dependencies* - It installed, at the very beginning of [its parent's Dockerfile](https://github.com/dockerfile/ubuntu/blob/master/Dockerfile), the [software-properties-common](https://packages.debian.org/sid/admin/software-properties-common) package, which in turns installed some Python3 packages.  I prefered to incorporate these stuff only when absolutely needed.

Therefore, I built this Docker image on my own, also as an exercise.



## Installation

   ```
   $ docker pull williamyeh/redis
   ```


## Usage


#### Show usage

```
$ docker run --rm williamyeh/redis
```
