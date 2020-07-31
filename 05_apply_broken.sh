#!/usr/bin/env bash
set -eo pipefail

kubectl config use-context kind-rabbit

# Apply broken CoreDNS config
kubectl apply -f ./kubeconfigs/coredns/broken_configmap.yml

# Ensure CoreDNS is reloaded
kubectl -n kube-system rollout restart deployment/coredns
kubectl -n kube-system rollout status deployment/coredns
