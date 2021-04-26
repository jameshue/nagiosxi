# Nagiosxi Deployment description

The compilation of this repository is all done in the podman environment.

### Base Docker Image

* [registry.access.redhat.com/ubi8/ubi](https://catalog.redhat.com/software/containers/ubi8/ubi/5c359854d70cc534b3a3784e?gti-tabs=unauthenticated&container-tabs=gti)


### Installation ( Dockerize )
The **Windows-10** environment is based on the following steps:
1. You can build an image from Windows-10/Dockerfile: **"docker build -t nagiosxi-ubi8 ."** .  (Linux running on WSL platform.)
2. Execute **“podman save nagiosxi -o nagiosxi-ubi8.tar”** and scp to a **VM** host that can connect to the internet.
3. Execute **"podman run -it --name nagios-ubi8 bash"** on the VM host, and then execute **"yum -y install nagiosxi"** in the container.
4. Exit the container and execute **"podman commit natiosxi-ubi8 natiosxi:5.8.3"** then execute **"podman save natiosxi:5.8.3 -o natiosxi-5.8.3.tar"** .
5. scp natiosxi-5.8.3.tar to the destination host you want to deploy.
6. Execute **"podman load -i natiosxi-5.8.3.tar"** on the destination host of your deployment.

The **Linux** environment is based on the following steps:
1. You can build an image from Linux/Dockerfile: **"docker build -t nagiosxi:latest ."** .
2. Execute **“podman save nagiosxi -o nagiosxi-latest.tar”** then scp nagiosxi-latest.tar to the destination host you want to deploy.
3. Execute **"podman load -i natiosxi-5.8.3.tar"** on the destination host of your deployment.

( In the Linux environment, since there is /var/run/podman/podman:sock, the image can be generated from the Dockerfile at once. )


### Usage ( Containerize )

#### Run `nagiosxi`

    podman run --privileged --name nagiosxi -v /sys/fs/cgroup:/sys/fs/cgroup:ro -p 80:80 -p 443:443 -d --name nagiosxi nagiosxi:latest

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
