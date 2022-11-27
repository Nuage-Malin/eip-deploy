#!/usr/bin/env bash

check_exit_failure()
{
    if [ $? -ne 0 ]
    then
        echo "$1" 1>&2
        exit 1
    fi
}

# Create Kubernetes cluster
kind create cluster --name nuage-malin --config=/app/kubernetes/cluster.yml -v 1
check_exit_failure "Fail to create cluster"

# Connect docker networks
docker network connect eip-deploy_kubernetes nuage-malin-control-plane
check_exit_failure "Fail to connect kubernetes network to the master node"
echo "Kubernetes network connected to the master node"
docker network connect eip-deploy_registry nuage-malin-worker
check_exit_failure "Fail to connect registry network to the production worker node"
echo "Registry network connected to the production worker node"
docker network connect eip-deploy_registry nuage-malin-worker2
check_exit_failure "Fail to connect registry network to the development worker node"
echo "Registry network connected to the worker node"

# Set Kubernetes config
kubectl config set clusters.kind-nuage-malin.server https://nuage-malin-control-plane:6443
check_exit_failure "Fail to set cluster server URL"

# Startup default resources
## Production
kubectl apply -f /app/kubernetes/production/users-db/
## Development
kubectl apply -f /app/kubernetes/development/users-db/