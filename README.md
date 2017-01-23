# server-docker-config
This is the configuration I am using on my server. My goal was to practice docker stuff and set up a multi user seedbox. I made heavy use of docker and nginx.

## Docker Folder Structure
There is a docker folder in each users home folder. The system docker folder is stored under `/opt/docker`

This is the structure for the docker folder:
```
|-- docker/
|   |-- containers/
|   |   |-- nginx/
|   |   |-- muximux/
|   |-- scripts/
|   |   |-- nginx.sh
|   |   |-- muximux.sh
```

The `scripts/` folder holds the docker create scripts. Each script is basically just copied from the docker hub page for each app.

The `containers/` folder hold the config files for the containers. The `.gitkeep` files are only there so the empty directories get added to github.

## Nginx Dockers
### System nginx
First there is the `nginx-system` container which handles the ssl connectivity, htaccess configuration, and user routing. It is the only nginx container with ports open to the internet, port 80 and 443. It will detect which user just logged in and connect to the appropriate nginx server for that user.

### User nginx
Each user has there own nginx docker. for example for the user named `jeremy` there is a docker called `jeremy-nginx`.
This docker handles all the reverse proxy settings for any other docker apps `jeremy` is running.

### Routing users
For the system nginx docker there is a config file called `users.conf` inside the `opt/docker/containers/nginx/config/` folder. It holds a few if statements that check which user is logged in and it will reverse proxy them to the users nginx docker.

## Docker Networks
Each user has their own network in docker. This allows the containers that the user runs to be isolated from the rest of the network. using these networks I can have the dockers talk directly to each other and avoid opening ports to the host. This also keeps things easier when managing multiple users as you have less ports to manage.

For example the `nginx` and `syncthing` dockers are able to work properly without any ports open to the network. In the users nginx container folder under `docker/containers/nginx/config/upstream/other.conf` file I set the upstream to the syncthing docker. Since I name all my docker containers with the user preceding the app name the hostname of the syncthing container is jeremy-syncthing. Syncthings web interface operates on port 8384. so I set the configuration accordingly. Because of the reverse proxy I don't have to open port 8384.
Here is an example of how it looks:. </br>
```
upstream syncthing {
    server jeremy-syncthing:8384;
}
```

Each users nginx docker uses this to provide access to the docker application through reverse proxy. Using this I can minimize the open ports on the server.

### Setting up and connecting the containers
The first thing you need to do before creating the containers is create the network for the user.<br/>
The network is created using the command:<br/>
`docker network create $USER-net`

To connect a docker to that network when you create it you need to use the `--net $USER-net` flag with the `docker create` command. this line is already included in the create scripts in the `docker/scripts/` folder.

To join a docker to multiple networks you can do that after the docker is created by running this command:<br/>
`docker network connect jeremy-net nginx-system`
This is how the nginx-system container connect to all the users networks. Just run it multiple times for each user. This command can be found in the `opt/docker/scripts/nginx.sh` file.


## References
I copied a lot of the configs for the reverse proxy settings from Thermionix post here. He also had the commands for the htpasswd stuff in the comments that I used to create the `htpasswd.sh` script.<br/>
https://gist.github.com/Thermionix/3375989<br/>

For a while I started setting things up using this guide from linuxserver.io:<br/>
https://www.linuxserver.io/2015/11/10/overview-reverse-proxy-with-docker/<br/>
I found that getting all the reverse proxy settings in apache working was not easy at all especially for muximux and glances. That's why I eventually switched to nginx. It was a great guide though and definetly helped me get started.


I used these guides to set up ssl and create the self signed certificates for nginx:<br/>
http://how2ssl.com/articles/openssl_commands_and_tips/<br/>
https://raymii.org/s/tutorials/Strong_SSL_Security_On_nginx.html<br/>
I used www.ssllabs.com to test it and I got an A if trust issues are ignored.


To set up the OpenVPN I used this guide: <br/>
https://www.digitalocean.com/community/tutorials/how-to-run-openvpn-in-a-docker-container-on-ubuntu-14-04<br/>
I didn't follow it exactly as i didn't really want to set up a Docker volume container to hold the configuration data. I don't see the benefits for storing it that way rather than on the host.<br/>
In part 5 of that guide there is intructions to set up the client on a bunch of different OS's. That's pretty helpfull to look up.
