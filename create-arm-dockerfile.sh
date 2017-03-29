#!/bin/bash

rm Dockerfile.arm
cp Dockerfile Dockerfile.arm

sed -i '' 's/ruby/busbyjon\/armv6-ruby/g' Dockerfile.arm
sed -i '' 's/# cross-compile-start/RUN [ "cross-build-start" ]/g' Dockerfile.arm
sed -i '' 's/# cross-compile-end/RUN [ "cross-build-end" ]/g' Dockerfile.arm


rm docker-compose.arm.yml
cp docker-compose.yml docker-compose.arm.yml

sed -i '' 's/redis:latest/hypriot\/rpi-redis:latest/g' docker-compose.arm.yml
sed -i '' 's/build: ./image: busbyjon\/jarvis:arm/g' docker-compose.arm.yml
sed -i '' 's/environment:/env_file: ..\/secrets.env/g' docker-compose.arm.yml
sed -i '' '/- REDIS_URL=redis:\/\/jarvis_redis\//d' docker-compose.arm.yml
sed -i '' '/- RAILS_ENV=development/d' docker-compose.arm.yml
