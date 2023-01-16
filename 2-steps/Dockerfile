FROM registry.access.redhat.com/ubi8/ubi:latest
MAINTAINER james.xu@asuscloud.com

ARG REDHAT_USERNAME
ARG REDHAT_PASSWORD

ENV  container docker
RUN  mkdir -p /usr/local/nagios/libexec
COPY nagios.pl /usr/local/nagios/libexec/slack_nagios.pl
COPY postzmsg /usr/local/nagios/libexec/
COPY postzmsg-nagios-host.sh /usr/local/nagios/libexec/
COPY postzmsg-nagios-service.sh /usr/local/nagios/libexec/
RUN  rm -rf /etc/localtime; \
	ln -s /usr/share/zoneinfo/Asia/Taipei /etc/localtime; \
	sed -i 's/\(def in_container():\)/\1\n    return False/g' /usr/lib64/python*/*-packages/rhsm/config.py; \
        subscription-manager register --username $REDHAT_USERNAME --password $REDHAT_PASSWORD; \
        subscription-manager repos --enable codeready-builder-for-rhel-8-x86_64-rpms; \
	yum -y install dnf-plugins-core; \
	yum -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm; \
	rpm -Uvh https://repo.nagios.com/nagios/8/nagios-repo-8-1.el8.noarch.rpm; \
	yum -y install cronie iputils net-tools initscripts perl-libwww-perl; \
	chmod 755 /usr/local/nagios/libexec/slack_nagios.pl /usr/local/nagios/libexec/postzmsg; \
	chmod 755 /usr/local/nagios/libexec/postzmsg-nagios-host.sh; \
	chmod 755 /usr/local/nagios/libexec/postzmsg-nagios-service.sh; \ 
	mkdir -p /usr/local/nagiosxi/tmp; chmod 777 /usr/local/nagiosxi/tmp; \
	mkdir -p /usr/local/nagiosxi/etc/configwizards; chmod 775 /usr/local/nagiosxi/etc/configwizards; \
 	yum -y install openssh-server elinks java-1.8.0-openjdk; \
	yum -y install glibc-2.28-151.el8.i686 libgcc-8.4.1-1.el8.i686 libnsl-2.28-151.el8.i686; \
	yum -y install libstdc++-8.4.1-1.el8.i686 libxcrypt-4.1.1-4.el8.i686; yum upgrade -y

RUN subscription-manager unregister

EXPOSE 80 443 5666 5667

RUN systemctl enable crond; \
	systemctl unmask systemd-logind.service

CMD ["/usr/sbin/init"]
