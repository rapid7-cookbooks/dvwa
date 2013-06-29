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
  source node[:dvwa][:url]
end

bash 'install_dvwa' do
  user 'root'
  code <<-eos
    if [[ -e #{node[:dvwa][:dir]}/* ]]; then
      rm -rf #{node[:dvwa][:dir]}/*
    fi

    unzip -q #{Chef::Config[:file_cache_path]}/#{node[:dvwa][:zip_name]} -d #{node[:dvwa][:dir]}
    rm -rf #{Chef::Config[:file_cache_path]}/#{node[:dvwa][:zip_name]}
  eos

  notifies :reload, 'service[apache2]', :immediately
end

template "#{node[:dvwa][:dir]}/config/config.inc.php"

package 'curl'
execute 'create/reset database' do
  command "curl --data 'create_db=Create+%2F+Reset+Database' http://0.0.0.0/dvwa/setup.php# --cookie PHPSESSID=1"
end

=begin
# NOTE: The http_request resource expects the data/response to be JSON
#   This causes issues when initializing the database. The above package/execute combo uses curl instead.
http_request "create/reset database" do
  action :post
  url 'http://0.0.0.0/dvwa/setup.php'
  message 'create_db' => 'Create+%2F+Reset+Database'
  headers({ 'PHPSESSID' => '1' })
end
=end
