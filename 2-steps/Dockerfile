FROM registry.access.redhat.com/ubi8/ubi:latest
MAINTAINER James.Hsu@ibm.com

ENV container docker
RUN  rm -rf /etc/localtime; \
	ln -s /usr/share/zoneinfo/Asia/Taipei /etc/localtime; \
	yum -y install dnf-plugins-core; \
	subscription-manager unregister; subscription-manager clean; \
 	subscription-manager register --username=service@cenoq.net --password=28004668 --auto-attach; \
	yum -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm; \
	subscription-manager repos --enable codeready-builder-for-rhel-8-x86_64-rpms; \
	rpm -Uvh https://repo.nagios.com/nagios/8/nagios-repo-8-1.el8.noarch.rpm; \
	yum -y install cronie iputils net-tools initscripts openssh-server links; \
	mkdir -p /usr/local/nagiosxi/tmp; chmod 777 /usr/local/nagiosxi/tmp; \
	mkdir -p /usr/local/nagiosxi/etc/configwizards; chmod 775 /usr/local/nagiosxi/etc/configwizards; \
 	yum upgrade -y


EXPOSE 80 443 5666 5667

RUN systemctl enable crond; \
	systemctl unmask systemd-logind.service

CMD ["/usr/sbin/init"]
