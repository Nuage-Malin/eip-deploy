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
docker stop eip-frontend
docker run --rm -d -p 80:80 --name eip-frontend eip-frontend:latest
check_exit_failure "Fail to run"