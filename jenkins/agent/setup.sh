#!/usr/bin/env sh

check_exit_failure()
{
    if [ $? -ne 0 ]
    then
        echo "$1" 1>&2
        sleep 10
        exit 1
    fi
}

# Check if Jenkins is ready
curl -s http://eip-deploy-jenkins-controller:$JENKINS_PORT | grep "Authentication required"
check_exit_failure "Jenkins not ready"

# Get agent executable
curl http://eip-deploy-jenkins-controller:$JENKINS_PORT/jnlpJars/agent.jar --output /app/agent.jar
check_exit_failure "Fail to download agent"

# Get agent secret
secret=`curl -L -s -u "Jenkins Agent:cc9c494ca8afcc43a0db7e8aa65662f6" -X GET http://eip-deploy-jenkins-controller:4242/computer/Nuage%20Malin%20Agent/jenkins-agent.jnlp | sed "s/.*<application-desc><argument>\([a-z0-9]*\).*/\1/"`
check_exit_failure "Fail to get agent secret"

# Startup default kubernetes resources
echo "Applying default kubernetes resources"
## Production
kubectl apply -f /app/kubernetes/production/users-db/
check_exit_failure "Fail to apply production users-db"
kubectl apply -f /app/kubernetes/production/cached-db/
check_exit_failure "Fail to apply production cached-db"
## Development
kubectl apply -f /app/kubernetes/development/users-db/
check_exit_failure "Fail to apply development users-db"
kubectl apply -f /app/kubernetes/development/cached-db/
check_exit_failure "Fail to apply development cached-db"
echo "All kubernetes resources applied"

# Start agent
java -jar /app/agent.jar -jnlpUrl http://eip-deploy-jenkins-controller:$JENKINS_PORT/computer/Nuage%20Malin%20Agent/jenkins-agent.jnlp -secret $secret
check_exit_failure "Fail to run agent"