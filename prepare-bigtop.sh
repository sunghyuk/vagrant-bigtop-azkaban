#!/usr/bin/bash

# Install Dependencies
sudo yum -y install git
 
# Install Puppet
sudo rpm -ivh http://yum.puppetlabs.com/puppetlabs-release-el-7.noarch.rpm
sudo yum -y install puppet
sudo puppet module install puppetlabs-stdlib

# Install Bigtop Puppet
sudo git clone https://github.com/apache/bigtop.git /bigtop-home
sudo sh -c "cd /bigtop-home; git checkout branch-1.2"
sudo cp -r /bigtop-home/bigtop-deploy/puppet/hieradata/ /etc/puppet/
sudo cp /bigtop-home/bigtop-deploy/puppet/hiera.yaml /etc/puppet/

