# Dockerfile for jenkins-master

### to build the docker image
```
mkdir -p /var/docker
cd /var/docker && git clone https://github.com/linhkikuchi/jenkins-master-docker.git
cd jenkins-master-docker && docker build -t jenkins-master .
```
### to launch jenkins master container
```
cd /var/docker/jenkins-master-docker && ./run.sh
```
### to run the container manualy
```
docker run -v /etc/pki/tls/certs:/etc/pki/tls/certs -v /etc/pki/tls/private:/etc/pki/tls/private -v /jenkins-backup:/var/jenkins_home -v /jenkins-war/jenkins.war:/usr/share/jenkins/jenkins.war --publish 8443:443 --restart always -d jenkins-master

```