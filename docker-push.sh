#!/bin/bash

#--- ARGS


#--- FUNCTIONS

function build {
  {
    NAME=$1
    BUILD_ENV=$2
    TAG=$(git log -1 --pretty=%h)
    IMG=$NAME:$TAG

    SERVICE=$(echo $NAME | cut -d "-" -f 2)

    echo "============================================="
    echo  "["$SERVICE"] Buidling: "$IMG""
    echo "============================================="

    docker build -t $IMG $SERVICE/
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

IMAGE=district0x/cljs-test

login
build $IMAGE
#push $IMAGE

exit $?
