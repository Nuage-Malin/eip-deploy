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
docker build -t localhost:5000/maestro:latest .
check_exit_failure "Fail to build"

# Push docker images in the docker registry
docker push localhost:5000/maestro:latest
check_exit_failure "Fail to push latest tag"
docker image rm localhost:5000/maestro:latest

# Deploy kubernetes
rm -rf /tmp/kubernetes/maestro
mkdir -p /tmp/kubernetes/maestro
cp /app/kubernetes/$1/maestro/* /tmp/kubernetes/maestro
sed -ie "s/THIS_STRING_IS_REPLACED_DURING_BUILD/$(date)/g" /tmp/kubernetes/maestro/*deployment*.y*ml
# kubectl apply -f /tmp/kubernetes/maestro/
# check_exit_failure "Fail to apply"