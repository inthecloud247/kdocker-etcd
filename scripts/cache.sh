#!/bin/bash

set -e

DIR="$( cd "$( dirname "$0" )" && pwd )"
CACHEDIR="$DIR/../setupfiles/cache"

DLFILES=(
  "github.com/coreos/etcd/releases/download/v0.2.0-rc3/etcd-v0.2.0-rc3-Linux-x86_64.tar.gz"
  )

for DLFILE in ${DLFILES[@]};
  do
    wget -P $CACHEDIR -p -c --no-check-certificate https://$DLFILE
  done;