#
# Cookbook Name:: dvwa
# Recipe:: standalone
#
# Copyright (c) 2013, Rapid7
#
# All Rights Reserved - Do Not Redistribute
#

# Ensure apt is up to date
include_recipe 'apt'

# Install Apache2
include_recipe 'apache2'
include_recipe 'apache2::mod_dav_fs'
include_recipe 'apache2::mod_php5'
include_recipe 'apache2::mod_ssl'

apache_site 'default'
apache_site 'default-ssl'

file '/var/www/index.html' do
  action :delete
end

# Install MySQL server
include_recipe 'mysql'
include_recipe 'mysql::server'

# Download DVWA as an archive
remote_file "#{Chef::Config[:file_cache_path]}/#{node[:dvwa][:zip_name]}" do
  action :create_if_missing
  source node[:dvwa][:url]
end

package 'unzip'
bash 'install DVWA from zip' do
  code <<-eos
    rm -rf #{node[:dvwa][:dir]}/dvwa
    unzip -q #{Chef::Config[:file_cache_path]}/#{node[:dvwa][:zip_name]} -d #{node[:dvwa][:dir]}
  eos

  notifies :reload, 'service[apache2]', :immediately
end

template '/var/www/dvwa/config/config.inc.php'

# Execute an HTTP request to create/reset the MySQL databse
# REVIEW: Should execute like: `curl --data 'create_db=Create+%2F+Reset+Database'
# http://localhost/dvwa/setup.php# --cookie PHPSESSID=1`
http_request "create/reset database" do
  action :post
  url 'http://localhost/dvwa/setup.php'
  message :create_db => 'Create+%2F+Reset+Database'
  headers({:PHPSESSID => 1})
end
