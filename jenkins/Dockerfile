FROM jenkins/jenkins:lts

ARG JENKINS_PORT=4242

LABEL MAINTAINER="Vincent Andrieu (vincent.andrieu@epitech.eu)"

WORKDIR /app

USER root
RUN apt-get update

# Install pip
RUN apt-get install -y python3-pip
# Install python YAML module
RUN pip install pyyaml

# Setup ssh
RUN mkdir -p ~/.ssh
RUN ssh-keyscan github.com >> ~/.ssh/known_hosts

# Setup Jenkins requirements
ENV JENKINS_HOME /home
ENV JENKINS_OPTS --httpPort=$JENKINS_PORT
ENV JAVA_OPTS -Djenkins.install.runSetupWizard=false
ENV CASC_JENKINS_CONFIG ${JENKINS_HOME}/jenkins.yaml

RUN jenkins-plugin-cli --verbose --plugins configuration-as-code github job-dsl script-security structs role-strategy

# Setup Jenkins config
COPY jenkins.yml ${JENKINS_HOME}/jenkins.yaml
COPY jenkins.groovy ${JENKINS_HOME}/job_dsl/jenkins.groovy
COPY users.yml /app/users.yml
COPY settings.py /app/settings.py
RUN python3 /app/settings.py /app/users.yml ${JENKINS_HOME}/jenkins.yaml
RUN rm /app/users.yml

# Uninstall/Clear packages
RUN pip uninstall -y pyyaml &&      \
    apt-get purge -y python3-pip && \
    apt-get autoremove -y &&        \
    apt-get autoclean -y &&         \
    apt-get clean -y &&             \
    rm -rf /var/lib/apt/lists/*