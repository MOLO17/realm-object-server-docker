#!/bin/bash

REALM_CONFIGURATION_FILE="/etc/realm/configuration.yml"

if [ ! -f "$REALM_CONFIGURATION_FILE" ]
then
	echo "$REALM_CONFIGURATION_FILE was not found"
	echo "Proceed with default configuration file creation"
	cp /usr/local/bin/realm-configuration.yml /etc/realm/configuration.yml
fi

echo "HERE"
echo "Prepare realm start"

# Force delete of files
rm -rf /realm-keys/id_rsa
rm -rf /realm-keys/id_rsa.pub

# Create key-pairs used by ROS
ssh-keygen -q -t rsa -N '' -f /realm-keys/id_rsa

ssh-keygen -f /realm-keys/id_rsa -e -m pem > /realm-keys/private_key.pem
ssh-keygen -f /realm-keys/id_rsa.pub -e -m pem > /realm-keys/public_key.pem

#openssl rsa -in /realm-keys/id_rsa -outform pem > /realm-keys/private_key.pem
#openssl rsa -in /realm-keys/id_rsa.pub -outform pem > /realm-keys/public_key.pem

# Create Sync Service realm directory
mkdir -p /var/realm/sync-services

/usr/bin/realm-object-server -c /etc/realm/configuration.yml