# Redis for Debian jessie
#
# URL: https://github.com/William-Yeh/docker-redis
#
# Reference:  https://github.com/dockerfile/redis
#
# Version     0.2
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
  rm -rf /tmp/redis-stable*

# Uninstall curl & compilation tools
RUN apt-get remove -y --auto-remove curl make gcc && \
    apt-get clean



# configure Redis
VOLUME [ "/data", "/etc/redis" ]
RUN \
  sed -i 's/^\(bind .*\)$/#\1/'       /etc/redis/redis.conf && \
  sed -i 's/^\(daemonize .*\)$/#\1/'  /etc/redis/redis.conf && \
  sed -i 's/^\(logfile .*\)$/#\1/'    /etc/redis/redis.conf && \
  sed -i 's/^\(dir .*\)$/dir \/data/' /etc/redis/redis.conf

#sed -i 's/^\(dir .*\)$/dir \/var\/lib\/redis/' /etc/redis/redis.conf


# Redis port.
EXPOSE 6379


# for convenience
ENV PATH /opt:$PATH
ADD usage.sh   /opt/
ADD start.sh   /opt/
ADD client.sh  /opt/
RUN date '+%Y-%m-%dT%H:%M:%S%:z' > /var/log/DOCKER_BUILD_TIME


# Define default command.
CMD ["usage.sh"]