FROM ubuntu:16.04
MAINTAINER Alessandro Benedetti <alessandro.benedetti@molo17.com>

# Realm Object Server will listen on that port 
EXPOSE 9080

# Following this guide, curl must be available to proceed with ROS setup
# https://realm.io/docs/realm-object-server/#install-realm-object-server

RUN apt-get update && \
	apt-get -y install curl

# Install OpenSSH Client used to generate Key Pairs
RUN apt-get -y install openssh-client 

# Setup Realm's PackageCloud repository
RUN curl -s https://packagecloud.io/install/repositories/realm/realm/script.deb.sh | bash

# Install the Realm Object Server
RUN apt-get -y install realm-object-server-de

# Enable and start the service
RUN systemctl enable realm-object-server

# Mount the volume with configuration file
VOLUME /etc/realm/
VOLUME /realm-keys/

# run.sh contains also script to verify that config file exists on mounted volume

ADD run.sh /usr/local/bin/run.sh
ADD realm-configuration.yml /usr/local/bin/realm-configuration.yml

RUN chmod +x /usr/local/bin/run.sh
CMD ["/usr/local/bin/run.sh"]