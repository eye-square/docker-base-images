FROM node:12

ENV DOCKER_VERSION="17.05.0-ce"
ENV COMPOSE_VERSION="1.13.0"
ENV NPM_CONFIG_LOGLEVEL warn
ENV LERNA_VERSION 3.4.3

# aws
RUN apt-get update && apt-get install -y python-dev python-pip
RUN pip install awscli && mkdir ~/.aws

# docker and docker compose
RUN curl -L -o /tmp/docker-$DOCKER_VERSION.tgz https://get.docker.com/builds/Linux/x86_64/docker-$DOCKER_VERSION.tgz && \
  tar -xz -C /tmp -f /tmp/docker-$DOCKER_VERSION.tgz && \
  mv /tmp/docker/* /usr/bin
RUN curl -L https://github.com/docker/compose/releases/download/$COMPOSE_VERSION/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose && \
  chmod +x /usr/local/bin/docker-compose

### node based apps ###
RUN yarn global add \
  lerna@${LERNA_VERSION}

# unit and integration test related deps:
## ffmpeg for our api
RUN apt-get update && apt-get install -y ffmpeg
