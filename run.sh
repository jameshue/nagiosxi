podman run --privileged --name nagiosxi -v /sys/fs/cgroup:/sys/fs/cgroup:ro -p 80:80 -p 443:443 -d --name nagiosxi nagiosxi:5.8.3
