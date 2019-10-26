FROM nodrama/cljs-dev:latest
MAINTAINER "Filip Bielejec" <nodrama.io>

RUN apt-get update -y \
    && apt-get install --no-install-recommends -y \
    -q python2.7 wget ca-certificates

RUN ln -s /usr/bin/python2.7 /usr/bin/python

RUN npm install -g truffle@4.1.14

RUN wget "https://raw.githubusercontent.com/technomancy/leiningen/stable/bin/lein" \
        && chmod a+x lein \
        && mv lein /usr/bin/lein \
        && lein --version
