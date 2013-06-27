# -*- mode: ruby -*-
# vi: set ft=ruby :

# NOTE: Grepping through ~/.vagrant.d/gems/specifications/ for installed versions isn't the way to do this
# TODO: Add Bundler/Berkshelf-like version management
# TODO: Try to use the Ruby equivalent (located in Vagrant's PluginCommand class) w/out OptParser
def plugin(name, version = nil, opts = {})
  puts "Inside of the plugin method: name: #{name}, version: #{version}, opts: #{opts}"
  @vagrant_home ||= opts[:home_path] || ENV['VAGRANT_HOME'] || "#{ENV['HOME']}/.vagrant.d"
  plugins = JSON.parse(File.read("#@vagrant_home/plugins.json"))

  condition = !plugins['installed'].include?(name) || (version && !version_matches(name, version))

  puts "condition: #{condition}"
  if condition
    cmd = "vagrant plugin install"
    cmd << " --entry-point #{opts[:entry_point]}" if opts[:entry_point]
    cmd << " --plugin-source #{opts[:source]}" if opts[:source]
    cmd << " --plugin-version #{version}" if version
    cmd << " #{name}"

    puts "Performing plugin installation."
    puts %x(#{cmd})
  end

  puts "#{condition ? 'Performed' : 'Skipped'} plugin installation."
end

def version_matches(name, version)
  gems = Dir["#@vagrant_home/gems/specifications/*"].map { |spec| spec.split('/').last.sub(/\.gemspec$/,'').split(/-(?:[\w\d]+\.?){1,}$/) }
  gem_hash = {}
  gems.each { |gem, v| gem_hash[gem] = v }

  puts "Version #{gem_hash[name]} of #{name} installed."
  gem_hash[name] == version
end

plugin 'vagrant-berkshelf', '1.3.2'
plugin 'vagrant-omnibus'

Vagrant.configure('2') do |config|
  config.berkshelf.enabled = true

  config.ssh.max_tries = 40
  config.ssh.timeout   = 120

  config.vm.box = 'precise64'
  config.vm.box_url = 'http://files.vagrantup.com/precise64.box'
  config.vm.hostname = 'dvwa-server'
  config.vm.network :private_network, ip: '33.33.33.10'

  config.vm.provision :chef_solo do |chef|
    chef.run_list = ['recipe[dvwa::server]']
  end
end
