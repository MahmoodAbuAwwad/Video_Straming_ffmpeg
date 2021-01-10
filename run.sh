#build the docker image
docker build -t webserver-ngnix --build-arg VID_NAME=$1 .

#Start the container
docker run -d -t -p 80:80 --name multimedia-networking webserver-ngnix 
