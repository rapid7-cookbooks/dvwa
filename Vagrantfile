# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure('2') do |config|
  config.berkshelf.enabled = true

  config.ssh.max_tries = 40
  config.ssh.timeout   = 120

  config.vm.hostname = 'dvwa-server'
  config.vm.box = 'ubuntu-12.04-omnibus-chef'
  config.vm.box_url = 'http://grahamc.com/vagrant/ubuntu-12.04-omnibus-chef.box'
  config.vm.network :private_network, ip: '33.33.33.10'

  config.vm.provision :chef_solo do |chef|
    chef.run_list = ['role[dvwa-server]']
  end
end
