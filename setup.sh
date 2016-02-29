#!/bin/bash

set -x -e

vagrant up
wget -c -O fly http://localhost:8080/api/v1/cli?arch=amd64&platform=darwin
chmod +x fly
./fly -t vagrant login -c http://localhost:8080 -u concourse -p test
./fly -t vagrant sp -p test -c pipeline.yml
./fly -t vagrant unpause-pipeline -p test
open http://localhost:8080
