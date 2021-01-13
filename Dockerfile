FROM centos:latest
MAINTAINER Fabián Salamanca <fabian.salamanca@rackspace.com> 
ENV DIR /apitest
WORKDIR $DIR
COPY runtest.sh $DIR
COPY requirements.txt $DIR
RUN dnf -y install python3 python3-virtualenv
RUN chown -R 1000 $DIR
USER 1000
RUN cd $DIR ; virtualenv robot; source robot/bin/activate; pip install -r requirements.txt

#ENTRYPOINT ["./runtest.sh", "quarkus.robot"]

