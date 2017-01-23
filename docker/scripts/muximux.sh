docker create \
    --name $USER-muximux \
    --net  $USER-net \
    --restart="always" \
    -e PUID=$(id -u) \
    -e PGID=$(id -g) \
    -e TZ=America/Denver    \
    -v ~/docker/containers/muximux:/config \
    linuxserver/muximux
