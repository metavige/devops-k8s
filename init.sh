#!/bin/bash

source .env

k3d cluster create $CLUSTER_NAME \
  -p 80:80@loadbalancer \
  -p 443:443@loadbalancer \
  --k3s-server-arg "--disable=traefik"

cd traefik
sh ./traefik-init.sh

cd $OLDPWD