FROM node:12-alpine

ENV NPM_CONFIG_LOGLEVEL warn
ENV LERNA_VERSION 3.4.3

RUN yarn global add \
  lerna@${LERNA_VERSION}
