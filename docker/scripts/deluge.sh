docker create \
    --name $USER-deluge \
    --net  $USER-net \
    --restart="always" \
    -p 49890-49899:49890-49899 \
    -e PUID=$(id -u) \
    -e PGID=$(id -g) \
    -e TZ=America/Denver \
    -v ~/downloads/torrents:/downloads \
    -v ~/docker/containers/deluge:/config \
    linuxserver/deluge
