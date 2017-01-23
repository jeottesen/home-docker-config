docker create \
    --name $USER-plexpy \
    --net  $USER-net \
    --restart="always" \
    -e PUID=$(id -u) \
    -e PGID=$(id -g) \
    -e TZ=America/Denver \
    -v ~/docker/containers/plexpy/:/config \
    -v ~/docker/containers/plex/config/Library/Application\ Support/Plex\ Media\ Server/Logs/:/logs:ro \
    linuxserver/plexpy
