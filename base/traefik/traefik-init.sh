#!/bin/bash

kubectl create secret tls traefik-certs \
  --cert=certs/_wildcard.k8s.internal.pem \
  --key=certs/_wildcard.k8s.internal-key.pem \
  -n kube-system

kubectl create configmap traefik-config \
  --from-file=ssl.yml=conf/ssl.yml \
  -n kube-system

helm install traefik traefik/traefik -n kube-system -f traefik-values.yaml

kubectl replace -f traefik-dashboard.yaml -n kube-system
