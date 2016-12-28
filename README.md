# Realm Object Server Docker-Ready // M17

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

	docker run -d -v /path/to/your/config/folder:/etc/realm -v /path/to/your/keys/folder:/realm-keys -p 9080:9080 molo17srl/realm-object-server:latest

*Private and public keys are always re-generated and they're stored to mounted volumes to be compliant with security standard rules.*

### TODO:
- [ ] Add environment variable to force delete of keys and configuration
- [ ] Insert envsubst or rb script to replace variables inside yml file
- [ ] Add environment variables to replace content of realm-configuration.yml


## RancherOS Configurations
***Tested with RancherOS, works succesfully behind Load Balancer which expose port 9080 to the world (or just access the 9080 via container address).***

___

***docker-compose.yml***
<pre><code>realm-object-storage-elb:
  ports:
  - 9080:9080
  tty: true
  image: rancher/load-balancer-service
  stdin_open: true
realm-object-storage:
  ports:
  - 9080:9080/tcp
  labels:
    io.rancher.container.pull_image: always
  tty: true
  image: molo17srl/realm-object-server:latest
  volumes:
  - /var/realm:/etc/realm
  - /var/realm-keys:/realm-keys
  stdin_open: true</code></pre>

___
***rancher-compose.yml***
<pre><code>realm-object-storage-elb:
  scale: 1
  load_balancer_config:
    haproxy_config: {}
  health_check:
    port: 42
    interval: 2000
    unhealthy_threshold: 3
    healthy_threshold: 2
    response_timeout: 2000
realm-object-storage:
  scale: 1</code></pre>