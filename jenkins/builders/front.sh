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
docker build -t localhost:5000/eip-frontend:${GIT_COMMIT} -t localhost:5000/eip-frontend:latest .
check_exit_failure "Fail to build"

# Push docker images in the docker registry
docker push localhost:5000/eip-frontend:${GIT_COMMIT}
check_exit_failure "Fail to push git commit tag"
docker push localhost:5000/eip-frontend:latest
check_exit_failure "Fail to push latest tag"

# Deploy kubernetes
## Apply client
# sed -ie "s/THIS_STRING_IS_REPLACED_DURING_BUILD/$(date)/g" production/client/kubernetes/client.deployment.yml
kubectl apply -f kubernetes/
check_exit_failure "Fail to apply"