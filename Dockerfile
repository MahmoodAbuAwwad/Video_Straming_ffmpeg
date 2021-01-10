FROM centos:centos7 as build


#---------------- Environment Vars  ---------------------\
ARG VID_NAME
ENV VIDEO_NAME=$VID_NAME

#RUN echo $VIDEO_NAME
#RUN printenv | grep $VIDEO_NAME   #--> validating vars.
#--------------------------------------------------------


#---------------- Import Video -------------------------
COPY . /root/.
#RUN ls /root
#-------------------------------------------------------


#----------------- setup ffmpeg and preparing workspace  -----------
RUN yum install -y epel-release
RUN yum -y localinstall --nogpgcheck https://download1.rpmfusion.org/free/el/rpmfusion-free-release-7.noarch.rpm
RUN yum install -y ffmpeg ffmpeg-devel
#RUN ffmpeg -version
RUN cd
RUN mkdir multimediaNetworking
WORKDIR multimediaNetworking
RUN mv /root/*.*  .  #copy video file from machine to container in the workspace
#RUN ls
#-------------------------------------------------------------------


#----------------- Installing MP4Box #--------------------------------
RUN yum install -y freetype-devel SDL-devel freeglut-devel
RUN yum install -y gpac
RUN yum install -y gettext tree 
#-------------------------------------------------------------------


#----- Generating video with different Resolution and Qualities ----
RUN ffmpeg -i $VIDEO_NAME -vf scale=1280:720 vid_res_720.mp4
RUN ffmpeg -i $VIDEO_NAME -vf scale=854:480 vid_res_480.mp4
RUN ffmpeg -i $VIDEO_NAME -vf scale=426:240 vid_res_240.mp4
RUN ffmpeg -y -i $VIDEO_NAME -qp 30 vid_qp_30.mp4
RUN ffmpeg -y -i $VIDEO_NAME -qp 10 vid_qp_10.mp4
RUN ffmpeg -y -i $VIDEO_NAME -qp 50 vid_qp_50.mp4
#-------------------------------------------------------------------


#---------------------- Generate mpd video  ------------------------
RUN MP4Box -dash 10000 -dash-profile live -out output vid_qp_10.mp4#video vid_qp_30.mp4#video vid_qp_50.mp4#video vid.mp4#video vid_res_240.mp4#video vid_res_480.mp4#video vid_res_720.mp4#video
#-------------------------------------------------------------------



#---------------------Copy File to ngnix Server and Rub it -------------------
FROM nginx:latest
RUN rm -rf /usr/share/nginx/html/*
COPY --from=build ./multimediaNetworking/. /usr/share/nginx/html/
RUN ls /usr/share/nginx/html/

EXPOSE 80
EXPOSE 8080


