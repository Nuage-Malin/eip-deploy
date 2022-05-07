#!/usr/bin/env bash

check_exit_failure()
{
    if [ $? -ne 0 ]
    then
        echo "$1" 1>&2
        exit 1
    fi
}

# Build docker images
docker build -t localhost:5000/eip-frontend:latest .
check_exit_failure "Fail to build"

# Push docker images in the docker registry
docker push localhost:5000/eip-frontend:latest
check_exit_failure "Fail to push latest tag"

# Pull docker image in the cluster
kind load docker-image --name nuage-malin "localhost:5000/eip-frontend:latest"
check_exit_failure "Fail to pull docker image in the cluster"

docker image rm localhost:5000/eip-frontend:latest
if [ $? -ne 0 ]
then
    echo "Fail to delete docker images" 1>&2
fi

# Deploy kubernetes
sed -ie "s/THIS_STRING_IS_REPLACED_DURING_BUILD/$(date)/g" kubernetes/*deployment*.y*ml
kubectl apply -f kubernetes/
check_exit_failure "Fail to apply"