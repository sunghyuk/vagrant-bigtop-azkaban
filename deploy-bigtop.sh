#!/usr/bin/bash

# Deploy
sudo puppet apply --parser future --modulepath=/bigtop-home/bigtop-deploy/puppet/modules:/etc/puppet/modules /bigtop-home/bigtop-deploy/puppet/manifests
