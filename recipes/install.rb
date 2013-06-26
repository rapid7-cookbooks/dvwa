#
# Cookbook Name:: dvwa
# Recipe:: install
#
# Copyright (c) 2013, Rapid7
#
# All Rights Reserved - Do Not Redistribute
#

include_recipe 'apt'
include_recipe 'xampp'
package 'curl'
package 'unzip'

unless File.exists? "#{node[:dvwa][:dir]}/dvwa"
  remote_file "#{Chef::Config[:file_cache_path]}/#{node[:dvwa][:zip_name]}" do
    action :create_if_missing
    source node[:dvwa][:url]
  end

  bash 'install_dvwa' do
    user 'root'
    cwd '/tmp'
    code <<-eos
      rm -rf #{node[:dvwa][:dir]}/dvwa &&
      unzip -q #{node[:dvwa][:zip_name]} -d #{node[:dvwa][:dir]} &&
      rm -rf #{node[:dvwa][:dir]}/dvwa/.htaccess
    eos
  end

  include_recipe 'dvwa::reset'
end
