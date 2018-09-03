FROM node:8.11-alpine

ENV NPM_CONFIG_LOGLEVEL warn

RUN yarn global add \
  lerna
