#!/usr/bin/env bash
set -eo pipefail

kubectl config use-context kind-rabbit

queue="test-$RANDOM"

echo "Declaring $queue"

# Declare one queue and bind queue to all messages '#'
kubectl exec pod/rabbitmq-0 -it -- rabbitmqadmin -u test -p test declare queue name=$queue durable=true
kubectl exec pod/rabbitmq-0 -it -- rabbitmqadmin -u test -p test declare binding source=test destination=$queue destination_type=queue routing_key='#'

# Spawn a simple consumer consuming messages in an endless loop
kubectl run --rm -i -t "rabbitmq-consume-$queue" --image=rabbitmq:3.8.5-management-alpine --restart=Never --env="QUEUE_NAME=$queue" -- sh -c '
  while true; do
    rabbitmqadmin -H rabbitmq-management -u test -p test get queue=$QUEUE_NAME ackmode=ack_requeue_false
    sleep 2
  done
'
