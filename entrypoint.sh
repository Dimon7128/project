#!/bin/bash

# Download the latest agent.jar if not present
if [ ! -f "/usr/share/jenkins/agent.jar" ]; then
    curl -sO http://15.236.30.185:8080/jnlpJars/agent.jar -o /usr/share/jenkins/agent.jar
fi

# Start the Jenkins agent
java -jar /usr/share/jenkins/agent.jar -jnlpUrl $JENKINS_URL/computer/Agent_WeatherApp1/jenkins-agent.jnlp -secret $JENKINS_SECRET -workDir $JENKINS_AGENT_WORKDIR
