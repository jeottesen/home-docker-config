docker run -v /opt/docker/containers/openvpn:/etc/openvpn --rm kylemanna/openvpn ovpn_genconfig -u udp://myservername:1194
docker run -v /opt/docker/containers/openvpn:/etc/openvpn --rm -it kylemanna/openvpn ovpn_initpki
