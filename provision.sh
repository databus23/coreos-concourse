#!/bin/bash
set -e -x
mkdir -p /opt/bin
wget --progress=dot:mega -c -O /opt/bin/docker-compose https://github.com/docker/compose/releases/download/1.5.2/docker-compose-Linux-x86_64
chmod +x /opt/bin/docker-compose
cd $(dirname $0)
modprobe btrfs
for i in $(seq 0 63); do
  [ -b /dev/loop$i ] || mknod -m 0660 /dev/loop$i b 7 $i
done
docker-compose -p concourse up -d
