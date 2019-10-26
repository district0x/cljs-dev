#!/bin/bash

#--- ARGS


#--- FUNCTIONS

function build {
  {
    NAME=$1
    TAG=$(git log -1 --pretty=%h)
    IMG=$NAME:$TAG

    echo "============================================="
    echo  "Buidling: "$IMG""
    echo "============================================="

    docker build -t $IMG .
    docker tag $IMG $NAME:latest

  } || {
    echo "EXCEPTION WHEN BUIDLING "$IMG""
    exit 1
  }

}

function push {
  NAME=$1
  echo "Pushing: " $NAME
  docker push $NAME
}

function login {
  echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin
}

#--- EXECUTE

IMAGE=district0x/cljs-dev

login
build $IMAGE
push $IMAGE

exit $?
