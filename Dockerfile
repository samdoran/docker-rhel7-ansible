FROM registry.access.redhat.com/rhel7
ENV container docker
ARG RHN_USERNAME
ARG RHN_PASSWORD

RUN (cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == systemd-tmpfiles-setup.service ] || rm -f $i; done); \
    rm -f /lib/systemd/system/multi-user.target.wants/*;\
    rm -f /etc/systemd/system/*.wants/*;\
    rm -f /lib/systemd/system/local-fs.target.wants/*; \
    rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
    rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
    rm -f /lib/systemd/system/basic.target.wants/*;\
    rm -f /lib/systemd/system/anaconda.target.wants/*;

RUN subscription-manager register --username=$RHN_USERNAME --password=$RHN_PASSWORD --autosubscribe \
    && subscription-manager repos --enable=rhel-7-server-extras-rpms \
    && yum -y install http://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm \
    && yum -y --enablerepo=epel-testing install ansible sudo cronie python-passlib openssh-server firewalld grub2 selinux-policy-targeted audit \
    && yum -y update \
    && rm -rf /var/cache/yum \
    && subscription-manager unregister

RUN sed -i 's/Defaults    requiretty/Defaults    !requiretty/g' /etc/sudoers

# Install Ansible inventory file.
RUN echo -e "localhost ansible_connection=local" > /etc/ansible/hosts

VOLUME ["/sys/fs/cgroup"]
CMD ["/usr/sbin/init"]
