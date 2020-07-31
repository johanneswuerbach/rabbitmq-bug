#!/usr/bin/env bash
set -eo pipefail

# Create an cluster named "rabbit", recreate if already exists
kind delete cluster --name rabbit
kind create cluster --name rabbit --config=./cluster/cluster.yaml

# Install CoreDNS 1.7.0 and wait until it is ready
kubectl -n kube-system set image deployment/coredns coredns=k8s.gcr.io/coredns:1.7.0
kubectl -n kube-system rollout status deployment/coredns

# Install rabbitmq and wait until it is ready
kubectl apply -f ./kubeconfigs/rabbitmq
kubectl rollout status statefulset/rabbitmq
