FROM nodrama/cljs-dev:latest
MAINTAINER "Filip Bielejec" <nodrama.io>

# add lein
# add truffle
# add ganache-cli

RUN npm install -g truffle@4.1.14 ganache-cli@6.1.8

EXPOSE 8549
EXPOSE 8545

RUN ls
RUN ls ~/.nvm/versions/node/v11.14.0/bin

# entrypoint .nvm/versions/node/v11.14.0/bin/truffle
