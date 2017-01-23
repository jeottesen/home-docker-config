docker create \
    --name $USER-nginx  \
    --net  $USER-net \
    --restart="always" \
    -v ~/docker/containers/nginx/html:/usr/share/nginx/html \
    -v ~/docker/containers/nginx/config:/etc/nginx/ \
    -v ~/docker/containers/nginx/ssl/private:/etc/ssl/private \
    -v ~/docker/containers/nginx/ssl/certs:/etc/ssl/certs \
    --log-opt max-size=1m \
    --log-opt max-file=1 \
    nginx
