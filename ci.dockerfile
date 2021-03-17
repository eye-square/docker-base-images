FROM eyesquare/base-images:main-5.1.2

ENV DOCKER_VERSION="5:19.03.13~3-0~debian-stretch"
ENV COMPOSE_VERSION="1.27.4"
ENV NPM_CONFIG_LOGLEVEL warn

# base services
RUN apt-get update && apt-get install -yq \
  apt-transport-https ca-certificates gnupg-agent \
  software-properties-common git

# docker
RUN curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add - && \
    apt-key fingerprint 0EBFCD88 && \
    add-apt-repository \
      "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable" && \
    apt-get update && \
    apt-get install -y docker-ce=${DOCKER_VERSION} docker-ce-cli=${DOCKER_VERSION} containerd.io && \
    docker --version

# docker-compose
RUN curl -L https://github.com/docker/compose/releases/download/$COMPOSE_VERSION/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose && \
    chmod +x /usr/local/bin/docker-compose
