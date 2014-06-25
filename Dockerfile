# Redis for Debian jessie
#
# URL: https://github.com/William-Yeh/docker-redis
#
# Reference:  https://github.com/dockerfile/redis
#
# Version     0.1
#

# pull base image
FROM debian:jessie
MAINTAINER William Yeh <william.pjyeh@gmail.com>

ENV DEBIAN_FRONTEND noninteractive
ENV TARBALL http://download.redis.io/redis-stable.tar.gz

# not absolutely necessary, but make Unix maintenance easier...
RUN apt-get update  &&  apt-get install -y procps


# Install curl & compilation tools
RUN apt-get install -y \
      curl \
      make \
      gcc


# Install Redis.
RUN \
  cd /tmp && \
  curl -O $TARBALL && \
  tar xvzf redis-stable.tar.gz && \
  cd redis-stable && \
  make && \
  make install && \
  cp -f src/redis-sentinel /usr/local/bin && \
  mkdir -p /etc/redis && \
  cp -f *.conf /etc/redis && \
  rm -rf /tmp/redis-stable* && \
  sed -i 's/^\(bind .*\)$/# \1/'            /etc/redis/redis.conf && \
  sed -i 's/^\(daemonize .*\)$/# \1/'       /etc/redis/redis.conf && \
  sed -i 's/^\(dir .*\)$/# \1\ndir \/data/' /etc/redis/redis.conf && \
  sed -i 's/^\(logfile .*\)$/# \1/'         /etc/redis/redis.conf


# Uninstall curl & compilation tools
RUN apt-get remove -y curl make gcc && \
    apt-get clean


# Define mountable directories.
VOLUME ["/data"]

# Define working directory.
WORKDIR /data

# Expose ports.
EXPOSE 6379

# Define default command.
CMD ["redis-server", "/etc/redis/redis.conf"]