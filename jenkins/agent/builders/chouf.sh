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
docker build -t chouf:latest .
check_exit_failure "Fail to build"

# Run docker images
docker stop chouf
docker run --rm -d -p 23234:23234 --name chouf chouf:latest
check_exit_failure "Fail to run"

# Create networks
docker network create chouf:maestro
if [ $? -ne 0 ]; then
    echo "chouf:maestro network already exists"
fi
docker network connect chouf:maestro chouf
check_exit_failure "Fail to connect chouf to chouf:maestro network"