podman run --privileged --name nagiosxi -v nagios-etc:/mnt/nagiosr-etc/ -v nagiosxi:/mnt/nagiosxi/ -v nagiosxi-mysql:/mnt/nagiosxi-mysql -v /sys/fs/cgroup:/sys/fs/cgroup:ro -p 80:80 -p 443:443 -d nagiosxi:5.8.5-1