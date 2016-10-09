# -*- mode: ruby -*-
# vi: set ft=ruby :

# TODO: add:  export PATH=$PATH:/usr/lib/postgresql/9.4/bin
# TODO: had to add vbenv-vars plugin for compose/ws-app

require 'json'

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/trusty64"
  config.vm.box_version = "20160809.1.0"

  config.vm.provision :shell, path: "bootstrap.sh"

  # config.vm.box_check_update = false

  config.vm.network "forwarded_port", guest: 80, host: 4567
  config.vm.network "forwarded_port", guest: 3000, host:3001
  config.vm.network "forwarded_port", guest: 4000, host:4001
  config.vm.network "forwarded_port", guest: 5432, host: 5433
  config.vm.network "forwarded_port", guest: 6432, host: 6433
  config.vm.network "forwarded_port", guest: 15432, host: 15433

  # config.vm.network "private_network", ip: "192.168.33.10"

  # config.vm.network "public_network"

  config.vm.synced_folder "./src", "/home/vagrant/vagrant-host"
  config.vm.synced_folder ".", "/vagrant", disabled: true

  config.vm.provider "virtualbox" do |vb|
    # Display the VirtualBox GUI when booting the machine
    vb.gui = false
    # Customize the amount of memory on the VM:
    vb.memory = "2048"
  end

  # Define a Vagrant Push strategy for pushing to Atlas. Other push strategies
  # such as FTP and Heroku are also available. See the documentation at
  # https://docs.vagrantup.com/v2/push/atlas.html for more information.
  # config.push.define "atlas" do |push|
  #   push.app = "YOUR_ATLAS_USERNAME/YOUR_APPLICATION_NAME"
  # end

  # Use Chef Solo to provision our virtual machine
  config.vm.provision :chef_solo do |chef|
    chef.cookbooks_path = ["cookbooks", "site-cookbooks"]
    chef.version = '12.10.24'
    chef.channel = 'stable'

    chef.add_recipe "apt"
    chef.add_recipe "user"
    chef.add_recipe "build-essential"
    chef.add_recipe "install-nvm"
    chef.add_recipe "arm-gcc"
    chef.add_recipe "particle-cli"
    chef.add_recipe "dfu-util"
    chef.add_recipe "ruby_build"
    chef.add_recipe "rbenv::user"
    chef.add_recipe "rbenv::vagrant"
    chef.add_recipe "vim"
#    chef.add_recipe "postgresql::ruby"
#    chef.add_recipe "postgresql::server"
#    chef.add_recipe "postgresql::client"
#    chef.add_recipe "lsoft-postgres"

    # Install Ruby 2.2.1 and Bundler
    # Set a default root password for postgres to make things simple
    file = File.read(File.dirname(File.expand_path(__FILE__)) + '/vagrant_chef_config.json')
    chef.json = JSON.parse file
  end
end
