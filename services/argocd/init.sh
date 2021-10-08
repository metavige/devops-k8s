#!/bin/bash

helm install argocd argocd-charts --create-namespace -n argocd
kubectl apply -f ingressroute.yaml
