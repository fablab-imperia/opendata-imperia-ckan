#!/bin/bash
echo "Starting docker-compose for building and running containers"
docker-compose up -d --build
echo "Restarting ckan container just in case..."
docker-compose restart ckan
docker ps | grep ckan 

echo "Available volumes:"
echo `docker volume ls | grep docker`
