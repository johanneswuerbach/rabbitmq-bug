#!/usr/bin/env bash
set -eo pipefail

kubectl config use-context kind-rabbit

# Rolling restart of the rabbitmq cluster and wait until it is ready
kubectl rollout restart statefulset/rabbitmq
kubectl rollout status statefulset/rabbitmq
