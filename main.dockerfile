FROM node:14.15.0-slim

ENV LERNA_VERSION 3.22.1

ENV NPM_CONFIG_LOGLEVEL warn
ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD true
ENV PLAYWRIGHT_SKIP_BROWSER_DOWNLOAD true

# base services
RUN apt-get update && apt-get install -yq --no-install-recommends \
    apt-utils wget gnupg openssl ranger vim curl git ca-certificates \
    && rm -rf /var/lib/apt/lists/* 

# ffmpeg
RUN apt-get update && apt-get install -yq --no-install-recommends ffmpeg

# chrome setup
RUN wget -v -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
    && sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list' \
    && apt-get update \
    && apt-get install -y google-chrome-unstable fonts-ipafont-gothic fonts-wqy-zenhei fonts-thai-tlwg fonts-kacst fonts-freefont-ttf \
      --no-install-recommends \
    && rm -rf /var/lib/apt/lists/*

# x11 setup
RUN apt-get update &&\
    apt-get install -yq --no-install-recommends \
    gconf-service libasound2 libatk1.0-0 libc6 libcairo2 libcups2 libdbus-1-3 \
    libexpat1 libfontconfig1 libgcc1 libgconf-2-4 libgdk-pixbuf2.0-0 libglib2.0-0 libgtk-3-0 libnspr4 \
    libpango-1.0-0 libpangocairo-1.0-0 libstdc++6 libx11-6 libx11-xcb1 libxcb1 libxcomposite1 \
    libxcursor1 libxdamage1 libxext6 libxfixes3 libxi6 libxrandr2 libxrender1 libxss1 libxtst6 \
    ca-certificates fonts-liberation libappindicator1 libnss3 lsb-release xdg-utils \
    xvfb x11vnc x11-xkb-utils xfonts-100dpi xfonts-75dpi xfonts-scalable xfonts-cyrillic x11-apps \
    && rm -rf /var/lib/apt/lists/* 

RUN yarn global add \
    lerna@${LERNA_VERSION} \
    && yarn cache clean