#!/bin/bash

source ${PWD}/../.env

kubectl create secret tls traefik-certs \
  --cert=certs/_wildcard.k8s.internal.pem \
  --key=certs/_wildcard.k8s.internal-key.pem \
  -n kube-system

kubectl create configmap traefik-config \
  --from-file=ssl.yml=conf/ssl.yml \
  -n kube-system

kubectl patch deployment traefik --type merge --patch "$(cat patch.yaml)" -n kube-system

kubectl apply -f tls-options/ssl.yaml -n kube-system
