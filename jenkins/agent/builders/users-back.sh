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
docker build -t localhost:5000/users-back:latest .
check_exit_failure "Fail to build"

# Push docker images in the docker registry
docker push localhost:5000/users-back:latest
check_exit_failure "Fail to push latest tag"
docker image rm localhost:5000/users-back:latest

# Deploy kubernetes
rm -rf /tmp/kubernetes/users-back
mkdir -p /tmp/kubernetes/users-back
cp /app/kubernetes/$1/users-back/* /tmp/kubernetes/users-back
sed -ie "s/THIS_STRING_IS_REPLACED_DURING_BUILD/$(date)/g" /tmp/kubernetes/users-back/*deployment*.y*ml
kubectl apply -f /tmp/kubernetes/users-back/
check_exit_failure "Fail to apply"