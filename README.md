Docker-Redis
============

## Summary

Repository name in Docker Hub: **[williamyeh/docker-redis](https://registry.hub.docker.com/u/williamyeh/docker-redis/)**

This repository contains **Dockerfile** of [Redis](http://redis.io/) for [Docker](http://www.docker.com/)'s [trusted build](https://registry.hub.docker.com/u/williamyeh/docker-redis/) published to the public [Docker Hub](https://hub.docker.com/).





## Configuration

This docker image contains the following software stack:

- OS: Debian jessie (built from [debian:jessie](https://registry.hub.docker.com/_/debian/)).

- Redis


### Dependencies

- [debian:jessie](https://registry.hub.docker.com/_/debian/).


### History

- 0.1 - This repository was forked from [dockerfile/redis](https://github.com/dockerfile/redis). 


## Why yet another Redis image for Docker?

There has been quite a few Redis images for Docker (e.g., [search](https://registry.hub.docker.com/search?q=redis) in the Docker Hub), so why reinvent the wheel?

In the beginning I used the [dockerfile/redis](https://github.com/dockerfile/redis). It worked well, but left some room for improvement:

- *Base OS image* - It was built from [dockerfile/ubuntu](https://registry.hub.docker.com/u/dockerfile/ubuntu/), which may not be the smallest one.  On the other hand, [debian:jessie](https://registry.hub.docker.com/_/debian/), as recommended in this [article](http://crosbymichael.com/dockerfile-best-practices-take-2.html), worth a try.

- *Unnecessary dependencies* - It installed, at the very beginning of [its parent's Dockerfile](https://github.com/dockerfile/ubuntu/blob/master/Dockerfile), the [software-properties-common](https://packages.debian.org/sid/admin/software-properties-common) package, which in turns installed some Python3 packages.  I prefered to incorporate these stuff only when absolutely needed.

Therefore, I built this Docker image on my own, also as an exercise.



## Installation on Docker-friendly OS

If you're using a Docker-friendly OS (e.g., CoreOS, Debian, Ubuntu) or Windows/MacOSX powered by [boot2docker](http://boot2docker.io/):

1. Install [Docker](http://www.docker.com/), if necessary.

2. Download this [trusted build](https://registry.hub.docker.com/u/williamyeh/docker-redis/) from public [Docker Hub](https://registry.hub.docker.com/):

   ```
   $ docker pull williamyeh/docker-redis
   ```

   (alternatively, you can build an image from Dockerfile: `docker build -t="williamyeh/docker-redis" github.com/William-Yeh/docker-redis`)



## Installation on Vagrant


### For the impatient

1. Copy the `Vagrantfile` of this project to your working directory.

2. Initialize and ssh into the Vagrant box:

   ```
   $ vagrant up
   $ vagrant ssh
   ```




### "Docker" provider

If you'd like to use the [Docker provider feature](https://www.vagrantup.com/blog/feature-preview-vagrant-1-6-docker-dev-environments.html) introduced since Vagrant 1.6:

1. Place a `Vagrantfile` in your working directory like this:

   ```
   VAGRANTFILE_API_VERSION = "2"
   DOCKER_IMAGE = "williamyeh/docker-redis"

   Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
       config.vm.define #{DOCKER_IMAGE} do |v|
           v.vm.provider "docker" do |d|
               d.image = #{DOCKER_IMAGE}
           end
       end
   end
   ```


2. Initialize the Docker container (with an implicit Vagrant box such as [mitchellh/boot2docker](https://github.com/mitchellh/boot2docker-vagrant-box), if necessary):

   ```
   $ vagrant up --provider=docker
   ``` 

3. See if Docker runs successfully:

   ```
   $ vagrant docker-logs
   ```


Vagrant 1.6 has also introduced Docker-related commands (e.g., `docker-logs` & `docker-run`). Consult the [official document](https://docs.vagrantup.com/v2/docker/commands.html) for more details.






## Usage


#### Run `redis-server`

```
$ docker run -d --name redis -p 6379:6379 williamyeh/docker-redis
```

#### Run `redis-server` with persistent data directory. (creates `dump.rdb`)

```
$ docker run -d -p 6379:6379 -v <data-dir>:/data --name redis williamyeh/docker-redis
```

#### Run `redis-server` with persistent data directory and password.

```
$ docker run -d -p 6379:6379 -v <data-dir>:/data --name redis williamyeh/docker-redis redis-server /etc/redis/redis.conf --requirepass <password>
```

#### Run `redis-cli`

```
$ docker run -it --rm --link redis:redis williamyeh/docker-redis bash -c 'redis-cli -h $REDIS_PORT_6379_TCP_ADDR'
```