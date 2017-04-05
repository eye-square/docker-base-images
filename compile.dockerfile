FROM node:6.9

ENV NPM_CONFIG_LOGLEVEL warn

RUN apt-get update && apt-get install -y ruby-full  && \
  gem update --system && gem install compass
RUN npm install --global gulp-cli
RUn npm install --global jpm
RUN curl -sS http://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
  echo "deb http://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
  apt-get update && apt-get install yarn

RUN mkdir core

COPY compile.core.package.json /core/package.json
# we install and remove all core packages to add them to the yarn cache.
# This should speed up installation time in our custom compile packages a lot
RUN cd core && yarn install && rm -r node_modules && cd /
