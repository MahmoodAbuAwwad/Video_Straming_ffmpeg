#we supposed this works for any machine with docker installed 

#for centos based
sudo yum install -y git 


#for ubuntu based Based
#sudo apt-get install git


#clone repo..
git clone https://github.com/MahmoodAbuAwwad/Video_Straming_ffmpeg.git


#build the docker image
docker build -t webserver-ngnix --build-arg VID_NAME=vid.mp4 .

#Start the container
docker run -d -t -p 80:80 --name multimedia-networking webserver-ngnix 
