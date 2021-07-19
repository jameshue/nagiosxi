podman run --privileged --name nagiosxi-ubi8 -v /sys/fs/cgroup:/sys/fs/cgroup:ro -p 80:80 -p 443:443 -d localhost/nagiosxi-ubi8:latest
