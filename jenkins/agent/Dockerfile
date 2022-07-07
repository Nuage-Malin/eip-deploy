FROM openjdk:19-alpine

ARG JENKINS_PORT=4242

LABEL MAINTAINER="Vincent Andrieu (vincent.andrieu@epitech.eu)"

WORKDIR /app

ENV JENKINS_PORT $JENKINS_PORT

RUN apk update && apk upgrade

# Install docker
RUN apk add docker

# Install kubernetes
## Install kubectl
RUN apk add curl
RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl
RUN chmod +x ./kubectl
RUN mv ./kubectl /usr/local/bin/kubectl
## Install kind
RUN curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.14.0/kind-linux-amd64
RUN chmod +x ./kind
RUN mv ./kind /usr/local/bin/kind

# Install Git
RUN apk add git openssh

# END
COPY setup.sh /app/setup.sh
COPY builders/ /app/builders/

CMD /app/setup.sh