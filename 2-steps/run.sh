podman run --privileged --name nagiosxi -v nagiosxi-etc:/usr/local/nagios/etc -v nagiosxi-mysql:/var/lib/mysql -v /sys/fs/cgroup:/sys/fs/cgroup:ro -p 80:80 -p 443:443 -d nagiosxi:5.8.3-1
