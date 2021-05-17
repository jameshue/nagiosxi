podman run --privileged --name nagiosxi-agent -v ncpa_etc:/usr/local/ncpa/etc -v /sys/fs/cgroup:/sys/fs/cgroup:ro -p 5693:5693 -d nagiosxi-agent:2.3.1-1
