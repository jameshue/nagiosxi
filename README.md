<img src="img/nagiosxi-container.svg" width="384">
# Nagiosxi Deployment description

The compilation of this repository is all done in the podman environment

### Schematic diagram of nagiosxi deployment process



### The installation steps of nagiosxi official website are as follows

* [RPM Repositories](https://repo.nagios.com/?repo=rpm-rhel)

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

#### Setup firewall

1. Check the status of your firewall.

   "# firewall-cmd --state"

2. Retrieve your currently active zones. Take a note of the zone within which you wish to open ports 80 and 443：

   "# firewall-cmd --get-active-zones"

3. Open port 80 and port 443 port permanently. Execute the below commands to open both ports permanently, hence, make the settings persistent after reboot:

   "# firewall-cmd --zone=public --permanent --add-service=http"  
   "# firewall-cmd --zone=public --permanent --add-service=https"  
   "# firewall-cmd --reload"

4. Check for open ports/services. The services with permanently open ports are listed on line starting with services:

   "# firewall-cmd --list-all"

#### Run `nagiosxi`

    podman run --privileged --name nagiosxi -v /sys/fs/cgroup:/sys/fs/cgroup:ro -p 80:80 -p 443:443 -d --name nagiosxi nagiosxi:latest

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
