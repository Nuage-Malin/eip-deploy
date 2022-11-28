#!/usr/bin/env sh

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
docker image rm localhost:5000/eip-frontend:latest

# Deploy kubernetes
rm -rf /tmp/kubernetes/front
mkdir -p /tmp/kubernetes/front
cp /app/kubernetes/$1/front/* /tmp/kubernetes/front
sed -ie "s/THIS_STRING_IS_REPLACED_DURING_BUILD/$(date)/g" /tmp/kubernetes/front/*deployment*.y*ml
kubectl apply -f /tmp/kubernetes/front/
check_exit_failure "Fail to apply"