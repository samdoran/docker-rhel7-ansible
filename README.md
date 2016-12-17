# RHEL 7 Ansible Test Image #
[![Build Status](https://travis-ci.org/samdoran/docker-rhel7-ansible.svg?branch=master)](https://travis-ci.org/samdoran/docker-rhel7-ansible)
[![Docker Pulls](https://img.shields.io/docker/pulls/mashape/kong.svg)](https://hub.docker.com/r/samdoran/rhel7-ansible/)

This is a container for testing Ansible roles.

## Build ##

In order to build a new image, set `RHN_USERNAME` and `RHN_PASSWORD` as environment variables, or pass them in directly to the the `docker build` command.

    docker build -t [image tag] --build-arg RHN_USERNAME=$RHN_USERNAME --build-arg RHN_PASSWORD=$RHN_PASSWORD .

## Run ##

    docker run -e TERM=xterm --rm -i -t samdoran/rhel7-ansible bash
