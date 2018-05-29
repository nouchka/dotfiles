#!/bin/sh

NAME=weave
BINARY=/usr/sbin/weave
VERSION=1.5.2
EXTRA_VERSION=1
DESCRIPTION='Simple, resilient multi-host Docker networking and more'
URL=https://github.com/weaveworks/weave
VENDOR='GoAbout'
MAINTAINER='Joost Cassee <joost.cassee@goabout.com>'
LICENSE='Apache License 2.0'

mkdir -p `dirname dist$BINARY`
wget -O dist$BINARY https://github.com/weaveworks/weave/releases/download/v$VERSION/weave
chmod 0755 dist$BINARY

rm -f weave_${VERSION}-${EXTRA_VERSION}_amd64.deb
fpm -t deb -s dir -n $NAME -v $VERSION-$EXTRA_VERSION --description "$DESCRIPTION" -C dist \
  --vendor "$VENDOR" -m "$MAINTAINER" --license "$LICENSE" --url $URL \
##  --after-install scripts/after-install --before-remove scripts/before-remove \
  --deb-no-default-config-files --config-files etc .
