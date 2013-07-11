#
# Cookbook Name:: dvwa
# Recipe:: xampp
#
# Copyright (c) 2013, Rapid7
#
# All Rights Reserved - Do Not Redistribute
#

node.set[:xampp][:security_policies] =	[
                                          'Order deny,allow',
                                          'Allow from all',
                                          'Allow from ::1 127.0.0.0/8 \
                                          fc00::/7 10.0.0.0/8 172.16.0.0/12 192.168.0.0/16 \
                                          fe80::/10 169.254.0.0/16',
                                          'ErrorDocument 403 /error/XAMPP_FORBIDDEN.html.var'
                                        ]
include_recipe 'xampp'

package 'unzip'
remote_file "#{Chef::Config[:file_cache_path]}/#{node[:dvwa][:zip_name]}" do
  source node[:dvwa][:url]
  only_if { node[:dvwa][:overwrite] || !Dir.exists?("#{node[:dvwa][:dir]}/dvwa") }
end

zip_path = "#{Chef::Config[:file_cache_path]}/#{node[:dvwa][:zip_name]}"

execute "unzip #{node[:dvwa][:zip_name]}" do
  command "unzip -q #{Chef::Config[:file_cache_path]}/#{node[:dvwa][:zip_name]} -d #{node[:dvwa][:dir]}"
  only_if { node[:dvwa][:overwrite] || !Dir.exists?("#{node[:dvwa][:dir]}/dvwa")  }
end

file zip_path do
  action :delete
  only_if { !::File.exists? zip_path }
end

xampp_service 'apache' do
  action :restart
end

template "#{node[:dvwa][:dir]}/dvwa/config/config.inc.php"

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
