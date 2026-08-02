#!/usr/bin/env bash

if [[ -z "${OLD_SERVER}" ]]; then
    echo "OLD_SERVER is either not set or it is empty."
    exit 1
fi

for service in bazarr  homarr  jellyfin  prowlarr  radarr  sabnzbd  seerr  sonarr; do
   echo "Syncing $service..."

   rsync -aHvhP \
       --delete \
       --exclude='cache/transcodes/' \
       --chown=1000:1000 \
       --no-owner \
       --no-group \
       -e ssh \
       abdullah@$OLD_SERVER:/opt/media-stack/config/$service/ \
       /opt/media-stack/config/$service/
done
