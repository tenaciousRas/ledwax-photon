# -*- mode: ruby -*-
# vi: set ft=ruby :

require 'json'

# TODO: add:  export PATH=$PATH:/usr/lib/postgresql/9.4/bin

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
#  config.vm.box = "ubuntu/trusty64"
#  config.vm.box_version = "20160809.1.0"
  config.vm.box = "lsoft/linux-mint-17-3-cinnamon-64-baremetal"
  config.vm.box_version = "0"

  config.vm.provision :shell, path: "bootstrap.sh"
  config.vm.box_check_update = false

  # default http
  config.vm.network :forwarded_port, guest: 80, host: 4567
  # middleware API port
  config.vm.network :forwarded_port, guest: 3000, host:3001
  # middleware public-web-ui port
  config.vm.network :forwarded_port, guest: 8000, host:8001
  # pgsql port
  config.vm.network :forwarded_port, guest: 5432, host: 5433
  # karma monitor port
  config.vm.network :forwarded_port, guest: 9876, host:9877
  # selenium standalone server port
  config.vm.network :forwarded_port, guest: 54299, host:54300
  # more ports for unexpected use
  config.vm.network :forwarded_port, guest: 3001, host:3002
  config.vm.network :forwarded_port, guest: 3002, host:3003
  config.vm.network :forwarded_port, guest: 3003, host:3004
  config.vm.network :forwarded_port, guest: 4000, host:4001
  config.vm.network :forwarded_port, guest: 6432, host: 6433
  config.vm.network :forwarded_port, guest: 15432, host: 15433

  # config.vm.network "private_network", ip: "192.168.33.10"

  # config.vm.network "public_network"

  config.vm.synced_folder "./src", "/home/vagrant/vagrant-host"
  config.vm.synced_folder ".", "/vagrant", disabled: true

  config.vm.provider "virtualbox" do |vb|
    # Display the VirtualBox GUI when booting the machine
    vb.gui = true
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
    chef.cookbooks_path = ["cookbooks"]
    chef.version = '12.10.24'
    chef.channel = 'stable'

    chef.add_recipe "apt"
    chef.add_recipe "user"
    chef.add_recipe "group"
    chef.add_recipe "build-essential"
    chef.add_recipe "install-nvm"
    chef.add_recipe "gcc-arm-embedded"
    chef.add_recipe "particle-cli"
    chef.add_recipe "dfu-util"
    chef.add_recipe "lsoft-postgres"
    chef.add_recipe "ruby_build"
    chef.add_recipe "rbenv::user"
    chef.add_recipe "rbenv::vagrant"
    chef.add_recipe "vim"

    file = File.read(File.dirname(File.expand_path(__FILE__)) + '/vagrant_chef_config.json')
    chef.json = JSON.parse file
  end
end
