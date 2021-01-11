FROM centos:latest
MAINTAINER fabian.salamanca@rackspace.com
WORKDIR /tmp
COPY quarkus.robot /tmp
COPY runtest.sh /tmp
COPY requirements.txt /tmp
RUN dnf -y install python3 python3-virtualenv
USER 1001
RUN cd /tmp ; virtualenv robot; source robot/bin/activate; pip install -r requirements.txt

ENTRYPOINT ["./runtest.sh","quarkus.robot"]

