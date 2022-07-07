FROM jenkins/jenkins:lts

ARG JENKINS_PORT=4242

LABEL MAINTAINER="Vincent Andrieu (vincent.andrieu@epitech.eu)"

WORKDIR /app

USER root
RUN apt-get update

# Install docker
RUN apt-get install -y \
    ca-certificates \
    curl \
    gnupg \
    lsb-release
RUN curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
RUN echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian \
    $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null
RUN apt-get update
RUN apt-get install -y docker-ce docker-ce-cli containerd.io

# Install Kubernetes
## Install kubectl
RUN apt-get install -y apt-transport-https
RUN curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
RUN echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | tee -a /etc/apt/sources.list.d/kubernetes.list
RUN apt-get update
RUN apt-get install -y kubectl
## Install kind
RUN curl -Lo ./kind "https://kind.sigs.k8s.io/dl/v0.12.0/kind-$(uname)-amd64"
RUN chmod +x ./kind
RUN mv ./kind /usr/local/bin/kind

# Install pip
RUN apt-get install -y python3-pip
# Install python YAML module
RUN pip install pyyaml

# Setup Jenkins requirements
ENV JENKINS_HOME /home
ENV JENKINS_OPTS --httpPort=$JENKINS_PORT
ENV JAVA_OPTS -Djenkins.install.runSetupWizard=false
ENV CASC_JENKINS_CONFIG ${JENKINS_HOME}/jenkins.yaml

RUN /usr/local/bin/install-plugins.sh configuration-as-code github job-dsl script-security structs role-strategy

# Setup Jenkins config
COPY jenkins.yml ${JENKINS_HOME}/jenkins.yaml
COPY jenkins.groovy ${JENKINS_HOME}/job_dsl/jenkins.groovy
COPY users.yml /app/users.yml
COPY settings.py /app/settings.py
RUN python3 /app/settings.py /app/users.yml ${JENKINS_HOME}/jenkins.yaml
RUN rm /app/users.yml

# Uninstall python YAML module
RUN pip uninstall -y pyyaml
# Uninstall pip
RUN apt-get purge -y python3-pip

# Copy files
COPY kubernetes/ /app/kubernetes/

CMD /app/kubernetes/setup.sh && /usr/local/bin/jenkins.sh