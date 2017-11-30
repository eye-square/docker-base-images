FROM node:6.11

ENV NPM_CONFIG_LOGLEVEL warn

RUN apt-get update && apt-get install -y ruby-full  && \
  gem update --system && gem install compass
RUN npm install --global gulp-cli
RUn npm install --global nodemon

RUN mkdir core

COPY package.json /core/package.json
# we install and remove all core packages to add them to the yarn cache.
# This should speed up installation time in our custom compile packages a lot
RUN cd core && yarn install && rm -r node_modules && cd /
