# RHEL 7 Ansible Test Image #
[![Build Status](https://travis-ci.org/samdoran/docker-rhel7-ansible.svg?branch=master)](https://travis-ci.org/samdoran/docker-rhel7-ansible) [![Docker Automated build](https://img.shields.io/docker/automated/samdoran/ubuntu12-ansible.svg?maxAge=2592000)](https://hub.docker.com/r/samdoran/rhel7-ansible)

This is a container for testing Ansible roles. It includes the latest version of Ansible and is rebuilt regularly using [Travis CI](https://travis-ci.org).

## Build ##

In order to build a new image, set `RHSM_USERNAME`, `RHSM_PASSWORD`, and `RHSM_POOL_ID` as environment variables, or pass them in directly to the the `docker build` command.

    docker build -t rhel6-ansible --build-arg RHSM_USERNAME=$RHSM_USERNAME --build-arg RHSM_PASSWORD=$RHSM_PASSWORD --build-arg RHSM_POOL_ID=$RHSM_POOL_ID .

## Testing a role inside the container ##

To run a role inside the container, you need to run the container with your role mounted inside it. I mount my current role directory as `/usr/share/ansible/roles/role_under_test` inside the container, but you can call it whatever you like.

    docker run --privileged -d --volume="$(pwd)":/usr/share/ansible/roles/role_under_test:ro --name ansible-test rhel7-ansible /sbin/init

Once your container is running with your role mounted inside it, you can run you test playbook included inside the role. This is a simple playbook that just runs `role_under_test` against `localhost`.

    docker exec -t ansible-test ansible-playbook /usr/share/ansible/roles/role_under_test/tests/test.yml

You can attach to the running container by using `docker exec`

    docker exec -i -t ansible-test bash

Once you are done testing, you can stop and remove the container.

    docker stop ansible-test
    docker rm ansible-test

## Automated Testing ##

You can automate the steps outlined above using [this script](https://gist.github.com/samdoran/c3d392ee697881fa33a1d1a65814a07b).
