docker create \
    --name openvpn-system \
    --restart="always" \
    -p 1194:1194/udp \
    -v /opt/docker/containers/openvpn/:/etc/openvpn \
    --cap-add=NET_ADMIN \
    kylemanna/openvpn
