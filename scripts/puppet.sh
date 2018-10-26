#!/bin/bash -eux

# Install Puppet repository.
#apt -y update && apt-get -y upgrade
#apt -y install wget
#wget https://apt.puppetlabs.com/puppet-release-xenial.deb
#sudo dpkg -i puppet-release-xenial.deb

# Install Puppet.
apt -y update && apt -y upgrade
apt -y install puppet
