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
docker build -t eip-frontend:latest .
check_exit_failure "Fail to build"

# Run docker images
if [ $1 == "production" ]
then
    docker run --rm -d -p $PRODUCTION_EIP_FRONT:80 --name eip-frontend eip-frontend:latest
else
    docker run --rm -d -p $DEVELOPMENT_EIP_FRONT:80 --name eip-frontend eip-frontend:latest
fi
check_exit_failure "Fail to run"