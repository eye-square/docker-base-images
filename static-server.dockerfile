FROM node:6.10

# Enviroment variables
ENV NPM_CONFIG_LOGLEVEL warn
ENV USER nodejs
ENV SERVER_SOURCE /static-server

# add user node and change dir working dir
RUN useradd -ms /bin/bash ${USER}
RUN mkdir -p ${SERVER_SOURCE}
WORKDIR ${SERVER_SOURCE}

# install server
COPY static-server/* ${SERVER_SOURCE}/
RUN yarn install --production --unsafe-perm

CMD ["node", "index.js"]
