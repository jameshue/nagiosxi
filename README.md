# Nagiosxi Deployment description

The compilation of this repository is all done in the podman environment

### Schematic diagram of nagiosxi deployment process

<img src="img/nagiosxi-container.svg" width="8194">

### The installation steps of nagiosxi official website are as follows

* [RPM Repositories of Nagiosxi](https://repo.nagios.com/?repo=rpm-rhel)

### Base Docker Image

* [registry.access.redhat.com/ubi8/ubi](https://catalog.redhat.com/software/containers/ubi8/ubi/5c359854d70cc534b3a3784e?gti-tabs=unauthenticated&container-tabs=gti)

### The deployment job has the following three configurations to be completed

- [Firewall configuration](#Firewall-configuration)
- [MySQL Database planning](#MySQL-Database-planning)
- [Configure systemd](#Configure-systemd)

### Build a Dockerfile image ( Dockerize )
The pre-operation steps for building a nagiosxi Docker image are as follows:

**1)** You can build an image from 2-steps/Dockerfile:  (Linux running on WSL platform.)

    docker build -t nagiosxi-ubi8 .

**2)** Execute the following command: 

    podman run --privileged --name nagiosxi -v nagiosxi-etc:/usr/local/nagios/etc -v /sys/fs/cgroup:/sys/fs/cgroup:ro -p 80:80 -p 443:443 -d nagiosxi:5.8.3-1

**3)** Execute the following command to enter the container： 

	podman exec -it --name nagiosxi bash

**4)** Then execute in the container follow:

	yum -y install nagiosxi

**5)** Leave the container and execute the following commands:

	podman commit natiosxi-ubi8 natiosxi:5.8.3-1

**6）** Then execute

	podman save natiosxi:5.8.3-1 -o natiosxi_5.8.3-1.tar

**7)** You can now scp **natiosxi_5.8.3-1.tar** to the destination host you want to deploy.

### Deploy ( Containerize )

#### Firewall configuration

**(1)** Check the status of your firewall.

    firewall-cmd --state

**(2)** Retrieve your currently active zones. Take a note of the zone within which you wish to open ports 80 and 443：

    firewall-cmd --get-active-zones

**(3)** Open port 80 and port 443 port permanently. Execute the below commands to open both ports permanently, hence, make the settings persistent after reboot:

    firewall-cmd --zone=public --permanent --add-service=http  
    firewall-cmd --zone=public --permanent --add-service=https  
    firewall-cmd --reload

**(4)** Check for open ports/services. The services with permanently open ports are listed on line starting with services:

    firewall-cmd --list-all


#### MySQL Database planning

1. Log in as a general user.
2. mkdir -p ~/username/nagiosxi/mysql
3. podman run --privileged --name nagiosxi -v /sys/fs/cgroup:/sys/fs/cgroup:ro \  
   -v /home/username/nagiosxi/mysql:/mnt/mysql \  
   -p 80:80 -p 443:443 -d --name nagiosxi nagiosxi:latest
4. podman exec -it nagiosxi bash
5. rsync -avA /var/lib/mysql /mnt/mysql
6. exit
7. podman stop nagiosxi
8. podman rm nagiosxi
10. podman run --privileged --name nagiosxi -v /sys/fs/cgroup:/sys/fs/cgroup:ro \  
   -v /home/username/nagiosxi/mysql:/var/lib/mysql \  
   -p 80:80 -p 443:443 -d --name nagiosxi nagiosxi:latest
    
#### Configure systemd

1. Log in as a general user.
2. sudo add **"net.ipv4.ip_unprivileged_port_start=0"** to /etc/sysctl.conf.
3. Execute **"mkdir ~/.config/systemd/user -p"**
4. Execute **"podman generate systemd nagiosxi > ~/.config/systemd/user/nagiosxi.service"**
5. Execute **"systemctl --user daemon-reload"**
6. Execute **"systemctl --user start nagiosxi.service"**
7. Execute **"systemctl --user status nagiosxi.service"** ( Make sure nagisxi.service is running )
8. Execute **"systemctl --user enable nagiosxi.service"**
9. Execute "sudo reboot" ( Make sure that nagiosxi.service is still running normally after the host is restarted )

Now you can visit the initialization webpage of nagiosxi

    http://host-ip_address or url-doman_name/nagiosxi
