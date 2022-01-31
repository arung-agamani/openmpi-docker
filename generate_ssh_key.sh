#!/bin/bash
set -eu -o pipefail

KEY_DIR=./.ssh
mkdir -p $KEY_DIR

set +e
yes | ssh-keygen -N "" -f $KEY_DIR/id_rsa
set -e
chmod 700 $KEY_DIR
chmod 600 -R $KEY_DIR/
echo "StrictHostKeyChecking no" >> $KEY_DIR/config