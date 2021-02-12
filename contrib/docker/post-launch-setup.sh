#!/bin/bash

#db setup
docker exec ckan /usr/local/bin/ckan -c /etc/ckan/production.ini datastore set-permissions | docker exec -i db psql -U ckan

#enable datastore and pusher
docker exec ckan sed -i 's/ckan.plugins = stats text_view image_view recline_view/ckan.plugins = stats text_view image_view recline_view datastore datapusher/' /etc/ckan/production.ini

#enable datapusher options
docker exec ckan sed -i 's/#ckan.datapusher.formats/ckan.datapusher.formats/' /etc/ckan/production.ini

#create admin user
docker exec -it ckan /usr/local/bin/ckan -c /etc/ckan/production.ini sysadmin add odiadmin

docker-compose restart ckan
docker-compose restart db
