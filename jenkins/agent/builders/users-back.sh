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

# Deploy kubernetes
rm -rf /tmp/kubernetes
mkdir /tmp/kubernetes
cp /app/kubernetes/$1/users-back/* /tmp/kubernetes
sed -ie "s/THIS_STRING_IS_REPLACED_DURING_BUILD/$(date)/g" /tmp/kubernetes/*deployment*.y*ml
kubectl apply -f /tmp/kubernetes/
check_exit_failure "Fail to apply"