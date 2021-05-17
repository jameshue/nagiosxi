FROM registry.access.redhat.com/ubi8/ubi:latest
MAINTAINER James.Hsu@ibm.com

ENV container docker
RUN  rm -rf /etc/localtime; \
	ln -s /usr/share/zoneinfo/Asia/Taipei /etc/localtime; \
        subscription-manager unregister; subscription-manager clean; \
        subscription-manager register --username=james.hsu@ibm.com --password="zaq12wsxCDE#$RFV" --auto-attach; \
	rpm -Uvh https://repo.nagios.com/nagios/8/nagios-repo-8-1.el8.noarch.rpm; \
	yum -y install ncpa cronie iputils net-tools initscripts;\
 	yum upgrade -y


EXPOSE 5693

RUN systemctl unmask systemd-logind.service

CMD ["/usr/sbin/init"]
