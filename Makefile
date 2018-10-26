# Set version variable to 0 if nothing is passed.
ifeq ($(version),)
  version := 0
endif

all: help

install:
	@echo "Installing dependencies..."
	@bundle
	@vagrant plugin install vagrant-vbguest
	@librarian-puppet install --path puppet/modules

packer:
	@echo "Starting packer build(s)..."
	@packer build -var "version_tag=${version}" ubuntu1804.json

start:
	@echo "Start VM(s)..."
	@vagrant up

clean:
	@echo "Destroying VM(s)..."
	@vagrant destroy -f

prune:
	@echo "Deleting VM image..."
	@vagrant box remove file://builds/virtualbox-ubuntu1804.box

help:
	@echo "the help menu"
	@echo "  make install       Install dependencies"
	@echo "  make packer        Start packer build(s)"
	@echo "  make start         Equivalent to vagrant up"
	@echo "  make clean         Force destruction of vagrant VM(s)"
	@echo "  make prune         Delete image(s) created by packer"
	@echo "  make test          Not implemented"

.PHONY: install start build clean prune test
