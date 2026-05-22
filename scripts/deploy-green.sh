#!/bin/bash

set -e

cd /opt/blue-green-deployment/runtime

export TAG=$1
export VERSION=$2

cp ~/docker-compose.green.yml .

sudo docker compose -f docker-compose.green.yml pull

sudo docker compose -f docker-compose.green.yml up -d

sleep 10

curl http://localhost:3002/health

curl http://localhost:5002/health


echo "GREEN DEPLOYMENT SUCCESS"