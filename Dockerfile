FROM circleci/clojure:lein-2.9.1
#adoptopenjdk/openjdk8:latest
MAINTAINER "Filip Bielejec" <nodrama.io>


# ENV variables
ENV NVM_VERSION 0.31.2
ENV NVM_DIR /usr/local/nvm
ENV NODE_VERSION 11.14.0
ENV LEIN_VERSION 2.9.1
ENV TRUFFLE_VERSION 4.1.14

ENV CHROME_BIN=/usr/bin/chromium-browser
ENV CHROME_PATH=/usr/lib/chromium/

USER root

# don't ask whether to restart services
# RUN apt-get -y install debconf-utils \
#         && echo '* libraries/restart-without-asking boolean true' | debconf-set-selections

RUN apt-get update -y && \
        apt-get install --no-install-recommends -yq \
        wget git python2.7  \
        && rm -rf /tmp/* /var/{tmp,cache}/* /var/lib/{apt,dpkg}/

# install lein
# RUN wget "https://raw.githubusercontent.com/technomancy/leiningen/stable/bin/lein" \
#         && chmod a+x lein \
#         && mv lein /usr/bin/lein \
#         && lein downgrade $LEIN_VERSION \
#         && lein --version

# install manually all the missing libraries
RUN apt-get install -y gconf-service libasound2 libatk1.0-0 libcairo2 libcups2 libfontconfig1 libgdk-pixbuf2.0-0 libgtk-3-0 libnspr4 libpango-1.0-0 libxss1 fonts-liberation libappindicator1 libnss3 lsb-release xdg-utils

# install chrome
RUN wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
RUN dpkg -i google-chrome-stable_current_amd64.deb; apt-get -fy install

# install nvm
RUN curl --silent -o- https://raw.githubusercontent.com/creationix/nvm/v$NVM_VERSION/install.sh | bash

# install node and npm
RUN . $NVM_DIR/nvm.sh \
    && nvm install $NODE_VERSION \
    && nvm alias default $NODE_VERSION \
    && nvm use default

# # add node and npm to PATH
ENV NODE_PATH $NVM_DIR/v$NODE_VERSION/lib/node_modules
ENV PATH $NVM_DIR/versions/node/v$NODE_VERSION/bin:$PATH

# git wget python2.7 ca-certificates chromium-browser curl git ssh tar gzip ca-certificates build-essential

# install truffle
RUN npm install -g truffle@${TRUFFLE_VERSION}

# RUN ln -s /usr/bin/python2.7 /usr/bin/python

# Create chromium wrapper with required flags
# RUN mv /usr/bin/chromium-browser /usr/bin/chromium-browser-origin && \
#         echo $'#!/usr/bin/env sh\n\
#         chromium-browser-origin --no-sandbox --headless --disable-gpu $@' > /usr/bin/chromium-browser && \
#         chmod +x /usr/bin/chromium-browser

USER circleci

RUN java -version
RUN lein --version
RUN node --version
RUN npm --version
RUN git --version
RUN python --version
RUN google-chrome --version
