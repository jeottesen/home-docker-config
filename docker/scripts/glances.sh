docker create \
    --name $USER-glances \
    --net  $USER-net \
    --restart="always" \
    -e GLANCES_OPT="-w" \
    -v /var/run/docker.sock:/var/run/docker.sock:ro \
    -v ~/docker/containers/glances:/glances/conf \
    --pid host \
    nicolargo/glances
