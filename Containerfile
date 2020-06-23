FROM registry.access.redhat.com/rhel7
ARG RHSM_USERNAME
ARG RHSM_PASSWORD
ARG RHSM_POOL_ID

ENV container=docker

RUN (cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == systemd-tmpfiles-setup.service ] || rm -f $i; done); \
    rm -f /lib/systemd/system/multi-user.target.wants/*;\
    rm -f /etc/systemd/system/*.wants/*;\
    rm -f /lib/systemd/system/local-fs.target.wants/*; \
    rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
    rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
    rm -f /lib/systemd/system/basic.target.wants/*;\
    rm -f /lib/systemd/system/anaconda.target.wants/*;

RUN subscription-manager register --username=$RHSM_USERNAME --password=$RHSM_PASSWORD \
    && subscription-manager attach --pool=$RHSM_POOL_ID \
    && subscription-manager repos \
        --enable rhel-7-server-ansible-2.8-rpms \
        --disable rhel-7-server-htb-rpms \
    && yum -y update \
    && yum -y install \
        ansible \
        audit \
        cronie \
        firewalld \
        grub2 \
        less \
        openssh-server \
        python-devel \
        python-passlib \
        selinux-policy-targeted \
        sudo \
        vim \
    && rm -rf /var/cache/yum \
    && subscription-manager unregister

RUN sed -i 's/Defaults    requiretty/Defaults    !requiretty/g' /etc/sudoers

RUN echo '# BLANK FSTAB' > /etc/fstab

# Install Ansible inventory file.
RUN echo -e "localhost ansible_connection=local ansible_python_interpreter=/usr/bin/python" > /etc/ansible/hosts

VOLUME ["/sys/fs/cgroup"]
CMD ["/usr/sbin/init"]
