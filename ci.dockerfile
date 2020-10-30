FROM node:14.15.0-slim

ENV DOCKER_VERSION="5:19.03.13~3-0~debian-stretch"
ENV COMPOSE_VERSION="1.27.4"
ENV LERNA_VERSION 3.22.1

ENV NPM_CONFIG_LOGLEVEL warn

# base services
RUN apt-get update && apt-get install -yq \
  apt-transport-https \
  ca-certificates \
  wget \
  gnupg \
  gnupg-agent \
  software-properties-common \
  openssl \
  ranger \
  vim \
  curl \
  git

# aws
RUN apt-get update && apt-get install -y python-dev python-pip
RUN pip install awscli && mkdir ~/.aws

# docker
RUN curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add - && \
  apt-key fingerprint 0EBFCD88 && \
  add-apt-repository \
    "deb [arch=amd64] https://download.docker.com/linux/debian \
    $(lsb_release -cs) \
    stable" && \
  apt-get update && \
  # uncomment to print available versions:
  # apt-cache madison docker-ce && \
  apt-get install -y docker-ce=${DOCKER_VERSION} docker-ce-cli=${DOCKER_VERSION} containerd.io && \
  docker --version
# docker-compose
RUN curl -L https://github.com/docker/compose/releases/download/$COMPOSE_VERSION/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose && \
  chmod +x /usr/local/bin/docker-compose

### node based apps ###
RUN yarn global add \
  lerna@${LERNA_VERSION}

# unit and integration test related deps:
## ffmpeg for our api
RUN apt-get update && apt-get install -y ffmpeg
