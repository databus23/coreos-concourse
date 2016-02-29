#!/bin/sh

case $1 in
  web)
    exec concourse web \
      --postgres-data-source=postgres://postgres@postgres/concourse?sslmode=disable \
      --external-url=http://localhost:8080 \
      --basic-auth-username=concourse \
      --basic-auth-password=test \
      -p \
      --session-signing-key=/secrets/session-signing-key \
      --tsa-host-key=/secrets/tsa-host-key \
      --tsa-authorized-keys=/secrets/worker-key.pub
    ;;
  worker)
    exec concourse worker \
      --work-dir=/workdir \
      --tsa-host=concourse \
      --tsa-public-key=/secrets/tsa-host-key.pub \
      --tsa-worker-private-key=/secrets/worker-key \
    ;;
  *)
    exec "$@"
esac
