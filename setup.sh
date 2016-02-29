#!/bin/bash

set -x -e

vagrant up
count=0
while ! curl -s -f -o /dev/null http://localhost:8080; do
  [ $count -ge 60 ] && exit 1
  count=$((count+1))
  echo "Waiting for http://localhost:8080..."
  sleep 1
done
platform=$(uname | tr '[:upper:]' '[:lower:]')
wget -c -O fly "http://localhost:8080/api/v1/cli?arch=amd64&platform=$platform"
chmod +x fly
./fly -t vagrant login -c http://localhost:8080 -u concourse -p test
./fly -t vagrant sp -n -p test -c pipeline.yml
./fly -t vagrant unpause-pipeline -p test
open http://localhost:8080
