# Realm Object Server Docker-Ready

> This is the very first version of our Realm Object Server test on Docker. We are open to receive any feedback to improve the codebase.

This aims to be a quick way to start using Realm Object Server with docker. 
ROS requires private and public key to startup, and a valid configuration file. 

With this image we are providing a basic configuration file, which will be used in case you don't provide anything. 
We also generate on the fly the required private and public keys, and we convert them to the PEM format so Realm can use them properly. 

## Volumes

	This image requires you to mount essentially two volumes:

	1. /path/to/your/keys/folder:/realm-keys
	2. /path/to/your/config/folder:/etc/realm

## Examples

	To start docker image, use the command below
	replacing path with your properly values.

	docker run -d -v /path/to/your/config/folder:/etc/realm -v /path/to/your/keys/folder:/realm-keys -p 9080:9080 molo17srl/realm-object-server:latest /bin/bash

*Private and public keys are always re-generated and they're stored to mounted volumes to be complaint with security standard rules.*