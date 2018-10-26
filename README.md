# Packer Example - Ubuntu 18.04.1 minimal Vagrant Box

This build installs and configures Ubuntu 18.04.1 minimal using Puppet, and then generates a Vagrant box file for VirtualBox.

## Ready-made Vagrant Box

- [`vagrant init markolly/ubuntu1804`](https://app.vagrantup.com/markolly/boxes/ubuntu1804)

## Requirements

The following software is required before you can use Packer to build the Vagrant image file:
  
  - [Ruby](https://www.ruby-lang.org/) (Tested on 2.1.10<)
  - [Bundler](https://bundler.io/) (Tested on 1.16.2)
  - [Packer](http://www.packer.io/) (Tested on v1.3.1)
  - [Vagrant](http://vagrantup.com/) (Tested on v2.1.5)
  - [VirtualBox](https://www.virtualbox.org/) (Tested on v5.2.20)

## Ruby
Puppet 3 is currently being used which requires ruby-2.1.10 or lower for it to function correctly

## Make
To "make" life simpler there is a Makefile with some bundled commands. More information about the commands can be found out by running "make help".
```
make help
the help menu
  make install       Install dependencies
  make packer        Start packer build(s)
  make start         Equivalent to vagrant up
  make clean         Force destruction of vagrant VM(s)
  make prune         Delete image(s) created by packer
  make test          Not implemented
```

#### Notes
> There is a post-processor configured to push built images to Vagrant Cloud automatically. For this to work a VAGRANT_CLOUD_TOKEN or ATLAS_TOKEN environment variable is required to be set. If this functionality isn’t required, the vagrant-cloud post-processor can just be removed. More information is available at [packer.io](https://www.packer.io/docs/post-processors/vagrant-cloud.html)
