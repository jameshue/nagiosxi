# Nagiosxi Deployment description

The compilation of this repository is all done in the podman environment.

### Base Docker Image

* [registry.access.redhat.com/ubi8/ubi](https://catalog.redhat.com/software/containers/ubi8/ubi/5c359854d70cc534b3a3784e?gti-tabs=unauthenticated&container-tabs=gti)


### Installation ( Dockerize )
The following steps are required to complete docker-image in the **Windows-10** environment:
1. You can build an image from Windows-10/Dockerfile: _**"docker build -t nagiosxi ."**_ .  (Linux running on WSL platform.)
2. Execute **“podman save nagiosxi -o nagiosxi-ubi.tar”** and scp to a **VM** host that can connect to the internet.
3. Execute "podman run -it --name nagios-ubi8 bash" on the VM host, and then execute "yum -y install nagiosxi".
4. 

   (alternatively, you can build an image from Dockerfile: `docker build -t="dockerfile/mongodb" github.com/dockerfile/mongodb`)


### Usage ( Containerize )

#### Run `mongod`

    docker run -d -p 27017:27017 --name mongodb dockerfile/mongodb

#### Run `mongod` w/ persistent/shared directory

    docker run -d -p 27017:27017 -v <db-dir>:/data/db --name mongodb dockerfile/mongodb

#### Run `mongod` w/ HTTP support

    docker run -d -p 27017:27017 -p 28017:28017 --name mongodb dockerfile/mongodb mongod --rest --httpinterface

#### Run `mongod` w/ Smaller default file size

    docker run -d -p 27017:27017 --name mongodb dockerfile/mongodb mongod --smallfiles

#### Run `mongo`

    docker run -it --rm --link mongodb:mongodb dockerfile/mongodb bash -c 'mongo --host mongodb'

##### Usage with VirtualBox (boot2docker-vm)

_You will need to set up nat port forwarding with:_  

    VBoxManage modifyvm "boot2docker-vm" --natpf1 "guestmongodb,tcp,127.0.0.1,27017,,27017"

This will allow you to connect to your mongo container with the standard `mongo` commands.
