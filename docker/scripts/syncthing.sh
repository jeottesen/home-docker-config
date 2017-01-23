docker create \
    --name $USER-syncthing \
    --net  $USER-net \
    --restart always \
    --user "$(id -u):$(id -g)" \
    -v ~/sync:$HOME \
    -v ~/docker/containers/syncthing:$HOME/.config/syncthing \
    -v /etc:/etc \
    -v /mnt:/mnt \
    -e STNODEFAULTFOLDER=1 \
    -e STNOUPGRADE=1 \
    tianon/syncthing
