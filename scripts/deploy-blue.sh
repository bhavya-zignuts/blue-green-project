#!/bin/bash

set -e

cd /opt/blue-green-deployment/runtime

export TAG=$1
export VERSION=$2

cp ~/docker-compose.blue.yml .

sudo docker compose -f docker-compose.blue.yml pull

sudo docker compose -f docker-compose.blue.yml up -d

sleep 10

curl http://localhost:3001/health

curl http://localhost:5001/health


echo "BLUE DEPLOYMENT SUCCESS"