# RHEL 7 Ansible Test Image #
[![Build Status](https://travis-ci.org/samdoran/docker-rhel7-ansible.svg?branch=master)](https://travis-ci.org/samdoran/docker-rhel7-ansible)
[![Docker Pulls](https://img.shields.io/docker/pulls/mashape/kong.svg)](https://hub.docker.com/r/samdoran/rhel7-ansible/)

This is a container for testing Ansible roles. It includes the latest version of Ansible and is rebuilt regularly using [Travis CI](https://travis-ci.org).

## Build ##

In order to build a new image, set `RHN_USERNAME` and `RHN_PASSWORD` as environment variables, or pass them in directly to the the `docker build` command.

    docker build -t rhel7-ansible --build-arg RHN_USERNAME=$RHN_USERNAME --build-arg RHN_PASSWORD=$RHN_PASSWORD .

## Testing a role inside the container ##

To run a role inside the container, you need to run the container with your role mounted inside it. I mount my current role directory as `/etc/ansible/roles/role_under_test` inside the container, but you can call it whatever you like.

    docker run --privileged -d --volume="$(pwd)":/etc/ansible/roles/role_under_test:ro --name ansible-test rhel7-ansible /sbin/init

Once your container is running with your role mounted inside it, you can run you test playbook included inside the role. This is a simple playbook that just runs `role_under_test` against `localhost`.

    docker exec -t ansible-test ansible-playbook ansible-playbook /etc/ansible/roles/role_under_test/tests/test.yml

You can attach to the running container by using `docker exec`

    docker exec -i -t ansible-test bash

Once you are done testing, you can stop and remove the container.

    docker stop ansible-test
    docker rm ansible-test
