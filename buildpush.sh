#!/bin/bash

echo "Building Docker image"
docker build -t samdoran/rhel7-ansible --build-arg RHN_USERNAME=$RHN_USERNAME --build-arg RHN_PASSWORD=$RHN_PASSWORD --build-arg POOL_ID=$POOL_ID .

echo "Pushing to Docker Hub"
docker push samdoran/rhel7-ansible
