docker create \
    --name nginx-system  \
    --restart="always" \
    -p 80:80 \
    -p 443:443 \
    -v /opt/docker/containers/nginx/html:/usr/share/nginx/html \
    -v /opt/docker/containers/nginx/config/:/etc/nginx/ \
    -v /opt/docker/containers/nginx/ssl/private:/etc/ssl/private \
    -v /opt/docker/containers/nginx/ssl/certs:/etc/ssl/certs \
    --log-opt max-size=1m \
    --log-opt max-file=1 \
    nginx

# Connect to users networks
docker network connect userOne-net nginx-system
docker network connect userTwo-net nginx-system
