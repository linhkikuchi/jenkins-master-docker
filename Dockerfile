FROM jenkinsci/jenkins:latest

 
VOLUME /etc/pki/tls/certs
VOLUME /etc/pki/tls/private
 
# disable setup wizard all together
ENV JAVA_OPTS '-Duser.timezone=Pacific/Auckland -Djenkins.install.runSetupWizard=false'
ENV JENKINS_OPTS ' \
 --httpPort=-1 \
 --httpsPort=443 \
 --httpsCertificate=/etc/pki/tls/certs/sli.io_combined.crt \
 --httpsPrivateKey=/etc/pki/tls/private/sli.io.key \
'


USER jenkins

# Install plugins
RUN /usr/local/bin/install-plugins.sh \
  git \
  active-directory \
  maven-plugin \
  parameterized-trigger \
  yet-another-docker-plugin \
  hipchat \
  mailer \
  rundeck \
  matrix-project

# Add groovy setup config
COPY init.groovy.d/activedirectory.groovy /usr/share/jenkins/ref/init.groovy.d/

USER root

# Add Jenkins URL and system admin e-mail config file
COPY jenkins.model.JenkinsLocationConfiguration.xml /var/jenkins_home/jenkins.model.JenkinsLocationConfiguration.xml
COPY hudson.tasks.Mailer.xml /var/jenkins_home/hudson.tasks.Mailer.xml

RUN apt-get update -y && apt-get install -y maven

# add key so that master can connect to slave
ADD id_dsa /root/.ssh/
RUN chmod 600 /root/.ssh/id_dsa

EXPOSE 443

RUN rm -f /etc/localtime \
 && ln -s /usr/share/zoneinfo/Pacific/Auckland /etc/localtime

VOLUME /var/jenkins_home


