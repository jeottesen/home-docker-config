# The plex library will not load on a mergerfs pool with direcetio turned on
# it breaks sqlite3 mmap. Plex Version 1.7.2.3878 on 6/7/2017
docker create \
    --name $USER-plex \
    --restart="always" \
    --net=host \
    -e TZ=America/Denver \
    -e PUID=$(id -u) \
    -e PGID=$(id -g) \
    -e VERSION=latest \
    -v ~/docker/containers/plex/config/:/config \
    -v /media/Media/:/data/ \
    -v ~/docker/containers/plex/transcode/:/transcode \
    linuxserver/plex 
