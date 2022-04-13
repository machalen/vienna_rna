####################################################
#Vienna software package
#Dockerfile to build a container with subread
#Ubuntu rolling 
####################################################
#Build the image based on Ubuntu
FROM ubuntu:rolling

#Maintainer and author
MAINTAINER Magdalena Arnal <magdalena.arnalsegura@iit.it>

#Install required libraries in ubuntu
RUN apt-get update && apt-get install --yes build-essential gcc-multilib apt-utils zlib1g-dev \
libbz2-dev perl gzip ncurses-dev libncurses5-dev libbz2-dev \
liblzma-dev libssl-dev libcurl4-openssl-dev libgdbm-dev libnss3-dev libreadline-dev libffi-dev wget

#Install python3
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get -yq install python3

#Install required libraries in ubuntu for samtools
RUN apt-get update -y && apt-get install -y unzip g++
#Set wokingDir in /bin
WORKDIR /bin

#Install and Configure samtools
RUN wget https://www.tbi.univie.ac.at/RNA/download/sourcecode/2_5_x/ViennaRNA-2.5.0.tar.gz
RUN tar -zxvf ViennaRNA-2.5.0.tar.gz
WORKDIR /bin/ViennaRNA-2.5.0
RUN ./configure
RUN make
RUN rm /bin/ViennaRNA-2.5.0.tar.gz
ENV PATH $PATH:/bin/ViennaRNA-2.5.0

# Cleanup
RUN apt-get clean
RUN apt-get remove --yes --purge build-essential gcc-multilib apt-utils zlib1g-dev

WORKDIR /
