FROM nodrama/cljs-dev:latest
MAINTAINER "Filip Bielejec" <nodrama.io>

# don't ask whether to restart services
RUN apt-get -y install debconf-utils \
        && echo '* libraries/restart-without-asking boolean true' | debconf-set-selections

RUN apt-get update -y \
        && apt-get install --no-install-recommends -yq \
        python2.7 wget ca-certificates chromium-browser \
        && rm -rf /tmp/* /var/{tmp,cache}/* /var/lib/{apt,dpkg}/

# Create chromium wrapper with required flags
RUN mv /usr/bin/chromium-browser /usr/bin/chromium-browser-origin && \
        echo $'#!/usr/bin/env sh\n\
        chromium-browser-origin --no-sandbox --headless --disable-gpu $@' > /usr/bin/chromium-browser && \
        chmod +x /usr/bin/chromium-browser

RUN ln -s /usr/bin/python2.7 /usr/bin/python

RUN npm install -g truffle@4.1.14

RUN wget "https://raw.githubusercontent.com/technomancy/leiningen/stable/bin/lein" \
        && chmod a+x lein \
        && mv lein /usr/bin/lein \
        && lein --version

ENV CHROME_BIN=/usr/bin/chromium-browser
ENV CHROME_PATH=/usr/lib/chromium/
