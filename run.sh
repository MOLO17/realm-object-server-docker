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

# If exists, delete sync folder
rm -rf /var/realm/sync-services

# # Recreatte sync folder
mkdir -p /var/realm/sync-services

# # Force delete of files
rm -rf /realm-keys/private_key.pem
rm -rf /realm-keys/public_key.pem

# # Create key-pairs used by ROS
openssl genrsa -out /realm-keys/private_key.pem 2048
openssl rsa -in /realm-keys/private_key.pem -outform PEM -pubout -out /realm-keys/public_key.pem

# Create Sync Service realm directory
mkdir -p /var/realm/sync-services

/usr/bin/realm-object-server -c /etc/realm/configuration.yml