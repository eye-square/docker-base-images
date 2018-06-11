FROM node:8.9

ENV NPM_CONFIG_LOGLEVEL warn

RUN yarn global add \
  lerna
