#!/bin/bash

kubectl create secret tls traefik-certs \
  --cert=config/certs/_wildcard.k8s.internal.pem \
  --key=config/certs/_wildcard.k8s.internal-key.pem \
  -n kube-system

kubectl create configmap traefik-config \
  --from-file=ssl.yml=config/conf/ssl.yml \
  -n kube-system

cat <<EOF >traefik-values.yaml
additionalArguments:
  - '--providers.file.directory=/etc/traefik/dynamic_conf'
  - '--entrypoints.websecure.http.tls=true'
volumes:
  - name: traefik-secret
    mountPath: '/certs'
    type: secret
  - name: traefik-config
    mountPath: '/etc/traefik/dynamic_conf'
    type: configMap
EOF

helm install traefik traefik/traefik -n kube-system -f traefik-values.yaml
rm traefik-values.yaml
