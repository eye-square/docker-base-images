FROM node:6.9

ENV  DOCKER_VERSION="17.03.0-ce"
ENV  COMPOSE_VERSION="1.11.2"

RUN curl -L -o /tmp/docker-$DOCKER_VERSION.tgz https://get.docker.com/builds/Linux/x86_64/docker-$DOCKER_VERSION.tgz && \
  tar -xz -C /tmp -f /tmp/docker-$DOCKER_VERSION.tgz && \
  mv /tmp/docker/* /usr/bin

RUN curl -L https://github.com/docker/compose/releases/download/$COMPOSE_VERSION/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose && \
  chmod +x /usr/local/bin/docker-compose
