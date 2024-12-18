FROM node:22.12.0-slim

ENV LERNA_VERSION=6

ENV NPM_CONFIG_LOGLEVEL=warn
ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true
ENV PLAYWRIGHT_SKIP_BROWSER_DOWNLOAD=true

# base services
RUN apt-get update &&\
    apt-get install -yq wget gnupg openssl ranger vim neovim curl python-dev-is-python3 python3-pip git jq awscli

# ffmpeg
RUN apt-get update && apt-get install -yq ffmpeg

# chrome setup
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | tee /etc/apt/keyrings/google.asc >/dev/null \
    && sh -c 'echo "deb [arch=amd64 signed-by=/etc/apt/keyrings/google.asc] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list' \
    && apt-get update \
    && apt-get install -y google-chrome-unstable fonts-ipafont-gothic fonts-wqy-zenhei fonts-thai-tlwg fonts-kacst fonts-freefont-ttf \
      --no-install-recommends \
    && rm -rf /var/lib/apt/lists/*

# x11 setup
RUN apt-get update &&\
    apt-get install -yq gconf-service libasound2 libatk1.0-0 libc6 libcairo2 libcups2 libdbus-1-3 \
    libexpat1 libfontconfig1 libgcc1 libgconf-2-4 libgdk-pixbuf2.0-0 libglib2.0-0 libgtk-3-0 libnspr4 \
    libpango-1.0-0 libpangocairo-1.0-0 libstdc++6 libx11-6 libx11-xcb1 libxcb1 libxcomposite1 \
    libxcursor1 libxdamage1 libxext6 libxfixes3 libxi6 libxrandr2 libxrender1 libxss1 libxtst6 \
    ca-certificates fonts-liberation libappindicator1 libnss3 lsb-release xdg-utils \
    xvfb x11vnc x11-xkb-utils xfonts-100dpi xfonts-75dpi xfonts-scalable x11-apps

RUN yarn global add \
    lerna@${LERNA_VERSION} \
    && yarn cache clean
