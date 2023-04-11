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
docker build -t landing-page:latest .
check_exit_failure "Fail to build"

# Run docker images
docker stop landing-page
docker run --rm -d -p 81:81 --name landing-page landing-page:latest
check_exit_failure "Fail to run"