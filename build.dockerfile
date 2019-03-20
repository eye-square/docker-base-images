FROM node:10-alpine

ENV NPM_CONFIG_LOGLEVEL warn

RUN yarn global add \
  lerna@3.4.3
