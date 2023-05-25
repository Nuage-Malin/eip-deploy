FROM openjdk:19-alpine

ARG JENKINS_PORT=4242

LABEL MAINTAINER="Vincent Andrieu (vincent.andrieu@epitech.eu)"

WORKDIR /app

ENV JENKINS_PORT $JENKINS_PORT

RUN apk update &&   \
    apk upgrade &&  \
    apk add --no-cache curl

# Install docker
RUN apk add --no-cache docker docker-cli-compose

# Install Git
RUN apk add --no-cache git openssh
RUN mkdir -p ~/.ssh
RUN ssh-keyscan github.com >> ~/.ssh/known_hosts

# END
COPY setup.sh /app/setup.sh
COPY builders/ /app/builders/
COPY docker-networks.sh /app/docker-networks.sh

CMD /app/setup.sh