FROM node:6.11

ENV  DOCKER_VERSION="17.03.0-ce"
ENV  COMPOSE_VERSION="1.11.2"
ENV  NPM_CONFIG_LOGLEVEL warn

RUN curl -L -o /tmp/docker-$DOCKER_VERSION.tgz https://get.docker.com/builds/Linux/x86_64/docker-$DOCKER_VERSION.tgz && \
  tar -xz -C /tmp -f /tmp/docker-$DOCKER_VERSION.tgz && \
  mv /tmp/docker/* /usr/bin

RUN curl -L https://github.com/docker/compose/releases/download/$COMPOSE_VERSION/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose && \
  chmod +x /usr/local/bin/docker-compose

RUN mkdir core

COPY package.json /core/package.json

RUN cd core && yarn install && rm -r node_modules && cd /
