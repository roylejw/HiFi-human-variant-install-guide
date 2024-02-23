# HiFi-human-variant-install-guide
A How-To guide on installing a local version of the HiFi-human-WGS-WDL pipeline on an AWS EC2 instance. There are many ways to do this, however this is how I have set it up. This will be superceded once AWS Genomics CLI is functioning again, but for now, we run this on a single local instance, with a minimum of 64 cores, and 256Gb of memory. I use a clean Ubuntu 20.04 AMI.

# Install Guide

## Install java
	sudo apt install openjdk-11-jre-headless

## Install cromwell
	wget https://github.com/broadinstitute/cromwell/releases/download/86/cromwell-86.jar
	mkdir cromwell
	mv cromwell-86.jar cromwell/
	
## Install Docker
### Add Docker's official GPG key:
	sudo apt-get update
	sudo apt-get install ca-certificates curl
	sudo install -m 0755 -d /etc/apt/keyrings
	sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
	sudo chmod a+r /etc/apt/keyrings/docker.asc

### Add the repository to Apt sources:
	echo \
	"deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
 	  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
	  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
	sudo apt-get update

	sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
	sudo docker run hello-world
	sudo chmod 666 /var/run/docker.sock

## Install WDL
	git clone https://github.com/PacificBiosciences/HiFi-human-WGS-WDL.git
	cd HiFi-human-WGS-WDL/
	git submodule update --init --recursive

## Download references
	wget https://zenodo.org/records/8415406/files/wdl-humanwgs.v1.0.2.resource.tgz?download=1
	mv wdl-humanwgs.v1.0.2.resource.tgz\?download\=1 wdl-humanwgs.v1.0.2.resource.tgz
	tar -xzvf wdl-humanwgs.v1.0.2.resource.tgz

## Install AWS CLI
	sudo apt-get install awscli
	aws configure
