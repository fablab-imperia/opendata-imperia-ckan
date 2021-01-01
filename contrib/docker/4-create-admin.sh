#!/bin/bash

echo "Creating user ckanadmin..."

docker exec -it ckan /usr/local/bin/ckan-paster --plugin=ckan sysadmin -c /etc/ckan/production.ini add ckanadmin

