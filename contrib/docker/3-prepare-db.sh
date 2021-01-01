#!/bin/bash

command_exists() {
    # check if command exists and fail otherwise
    command -v "$1" >/dev/null 2>&1
    if [[ $? -ne 0 ]]; then
        echo "I require $1 but it's not installed. Abort."
        exit 1
    fi
}

command_exists "jq"

# Find the path to a named volume
docker volume inspect docker_ckan_home | jq -c '.[] | .Mountpoint'
# "/var/lib/docker/volumes/docker_ckan_config/_data"

export VOL_CKAN_HOME=`docker volume inspect docker_ckan_home | jq -r -c '.[] | .Mountpoint'`
echo "CKAN_HOME=$VOL_CKAN_HOME"

export VOL_CKAN_CONFIG=`docker volume inspect docker_ckan_config | jq -r -c '.[] | .Mountpoint'`
echo "VOL_CKAN_CONFIG=$VOL_CKAN_CONFIG"

export VOL_CKAN_STORAGE=`docker volume inspect docker_ckan_storage | jq -r -c '.[] | .Mountpoint'`
echo "VOL_CKAN_STORAGE=$VOL_CKAN_STORAGE"

docker exec ckan /usr/local/bin/ckan-paster --plugin=ckan datastore set-permissions -c /etc/ckan/production.ini | docker exec -i db psql -U ckan

echo "Please now edit $VOL_CKAN_CONFIG/production.ini and add datastore datapusher to ckan.plugins and enable the datapusher option ckan.datapusher.formats."

docker-compose restart ckan

