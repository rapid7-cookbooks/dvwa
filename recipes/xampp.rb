#
# Cookbook Name:: dvwa
# Recipe:: xampp
#
# Copyright (c) 2013, Rapid7
#
# All Rights Reserved - Do Not Redistribute
#

include_recipe 'apt'
include_recipe 'xampp'
package 'unzip'

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

# Restart Apache 2 and create/reset database
service 'apache2' do
  action :reload
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
