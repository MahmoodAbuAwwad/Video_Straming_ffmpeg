# Video_Straming_ffmpeg

* Place video with Docker file in one directory  





Run script => run.sh

---------------------------------------------------
Or Manually =>

* Build the Image

 docker build -t ImageName --build-arg VID_NAME=NameOfVideo  Workspace
	docker build -t webserver-ngnix --build-arg VID_NAME=vid.mp4 .

* Start the Container 

docker run -d -t --net=host --name ContainerName ImageName
docker run -d -t -p 80:80 --name ContainerName ImageName



