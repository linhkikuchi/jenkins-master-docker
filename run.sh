#!/bin/bash

# to run
mkdir -p /jenkins-backup
mkdir -p /jenkins-war
cd /jenkins-war && wget https://updates.jenkins-ci.org/download/war/2.85/jenkins.war

docker run --name jenkins-master -v /etc/pki/tls/certs:/etc/pki/tls/certs -v /etc/pki/tls/private:/etc/pki/tls/private -v /jenkins-backup:/var/jenkins_home -v /jenkins-war/jenkins.war:/usr/share/jenkins/jenkins.war --publish 8443:443 --restart always -d jenkins-master
