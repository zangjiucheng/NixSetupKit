#!/bin/sh

cd ./navidrome/
docker-compose up -d
cd ../immich-app/
docker-compose up -d
cd ../calibre-web/
docker-compose up -d
cd ..
