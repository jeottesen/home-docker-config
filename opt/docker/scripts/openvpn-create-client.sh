help='usage: openvpn-create-client.sh [username]'

if [[ -z $1 ]]; then
    echo $help
elif [[ $1 == "-h" ]]; then
        echo $help
else
    #docker run -v /opt/docker/containers/openvpn:/etc/openvpn --rm -it kylemanna/openvpn easyrsa build-client-full $1 nopass
    docker run -v /opt/docker/containers/openvpn:/etc/openvpn --rm kylemanna/openvpn ovpn_getclient $1 > $1.ovpn
fi

