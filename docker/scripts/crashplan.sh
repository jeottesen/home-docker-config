docker create \
  --name $USER-crashplan \
  --restart="always" \
  -h hostname \
  -e TZ=America/Denver \
  -p 4242:4242 -p 4243:4243 \
  -v ~/docker/containers/crashplan/data:/var/crashplan \
  -v /media/Media:/Media \
  jrcs/crashplan:latest
