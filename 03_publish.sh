#!/usr/bin/env bash

set -eo pipefail

kubectl config use-context kind-rabbit

# Declare a topic exchange
kubectl exec pod/rabbitmq-0 -it -- rabbitmqadmin -u test -p test declare exchange name=test type=topic

# Spawn a simple publisher publishing messages in an endless loop
kubectl run --rm -i -t rabbitmq-publish --image=rabbitmq:3.8.5-management-alpine --restart=Never -- sh -c '
  while true; do
    rabbitmqadmin -H rabbitmq-management -u test -p test publish routing_key='"'"'#'"'"' payload="test $(date)" exchange=test
    sleep 2
  done
'
