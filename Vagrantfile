# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
	config.vm.box = "ubuntu/trusty64"

	config.vm.provision "shell", path: "bootstrap.sh"

	config.vm.network "private_network", ip: "192.168.99.99"

	config.vm.synced_folder "./", "/vagrant", id: "vagrant-root",
		owner: "www-data", group: "www-data", mount_options: ["dmode=777,fmode=777"]
end
