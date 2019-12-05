#!/usr/bin/env bash

IMAGE=mattrayner/lamp:latest
DC=''
WDIR=$(git rev-parse --show-toplevel)

if command -v 'docker'; then
    DC='docker'
elif command -v 'podman'; then
    DC='podman'
else
    echo "Neither Docker or Podman installed, can't run!"
    exit
fi

$DC run --name volunteering --rm -v $WDIR/src:/app -v $WDIR/vendor:/vendor -p 8080:80 $IMAGE
