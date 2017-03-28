#!/bin/bash

rm Dockerfile.arm
cp Dockerfile Dockerfile.arm

sed -i '' 's/ruby/busbyjon\/armv6-ruby/g' Dockerfile.arm
sed -i '' 's/# cross-compile-start/RUN [ "cross-build-start" ]/g' Dockerfile.arm
sed -i '' 's/# cross-compile-end/RUN [ "cross-build-end" ]/g' Dockerfile.arm

