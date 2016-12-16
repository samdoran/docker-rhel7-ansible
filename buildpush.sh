#!/bin/bash

echo "Building Docker image"
docker build -t samdoran/rhel7-ansible --build-arg RHN_USERNAME=$RHN_USERNAME --build-arg RHN_PASSWORD=$RHN_PASSWORD .

echo "Pushing to Docker Hub"
docker push samdoran/rhel7-ansible
