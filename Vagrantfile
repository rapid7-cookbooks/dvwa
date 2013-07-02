# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure('2') do |config|
  config.berkshelf.enabled = true
  config.omnibus.chef_version = :latest

  config.vm.define :standalone do |standalone_config|
    standalone_config.ssh.max_tries = 40
    standalone_config.ssh.timeout   = 120

    standalone_config.vm.box = 'precise64'
    standalone_config.vm.box_url = 'http://files.vagrantup.com/precise64.box'
    standalone_config.vm.hostname = 'dvwa-standalone'
    standalone_config.vm.network :private_network, ip: '33.33.33.10'

    standalone_config.vm.provision :chef_solo do |chef|
      chef.json = {
        apache2: {
          mod_ssl: {
            cipher_suite: 'LOW:HIGH:MEDIUM:+EXP:+SHA1:+MD5:+LOW:+HIGH:+MEDIUM',
            protocol: '+all'
          }
        },
        mysql: {
          bind_address: '127.0.0.1',
          server_debian_password: 'msfadmin',
          server_root_password: 'msfadmin',
          server_repl_password: 'msfadmin'
        },
      }
      chef.run_list = ['recipe[dvwa::standalone]']
    end
  end

  config.vm.define :xampp do |xampp_config|
    xampp_config.ssh.max_tries = 40
    xampp_config.ssh.timeout   = 120

    xampp_config.vm.box = 'precise64'
    xampp_config.vm.box_url = 'http://files.vagrantup.com/precise64.box'
    xampp_config.vm.hostname = 'dvwa-xampp'
    xampp_config.vm.network :private_network, ip: '33.33.33.11'

    xampp_config.vm.provision :chef_solo do |chef|
      chef.run_list = ['recipe[dvwa::xmapp]']
    end
  end
end
