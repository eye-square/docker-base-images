FROM node:6.10

ENV NPM_CONFIG_LOGLEVEL warn

RUN apt-get update && apt-get install -y ruby-full  && \
  gem update --system && gem install compass
RUN npm install --global gulp-cli
RUn npm install --global jpm

COPY data data
COPY bin /build-scripts
# we install and remove all core packages to add them to the yarn cache.
# This should speed up installation time in our custom compile packages a lot
RUN ./build-scripts/extract-packages.sh
RUN rm -r /build-scripts
