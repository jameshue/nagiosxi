FROM registry.access.redhat.com/ubi8/ubi:latest
MAINTAINER James.Hsu@ibm.com

ENV container docker
RUN  rm -rf /etc/localtime; \
	ln -s /usr/share/zoneinfo/Asia/Taipei /etc/localtime; \
	yum -y install dnf-plugins-core; \
	subscription-manager register --username=service@cenoq.net --password=28004668 --auto-attach; \
	yum -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm; \
	subscription-manager repos --enable codeready-builder-for-rhel-8-x86_64-rpms; \
	rpm -Uvh https://repo.nagios.com/nagios/8/nagios-repo-8-1.el8.noarch.rpm; \
	yum -y install cronie initscripts openssh-server links; \
	yum -y install nagiosxi; yum upgrade -y

EXPOSE 80 443 5666 5667

RUN systemctl enable crond

CMD ["/usr/sbin/init"]
