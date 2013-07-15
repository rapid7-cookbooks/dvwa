#
# Cookbook Name:: dvwa
# Recipe:: standalone
#
# Copyright (c) 2013, Rapid7
#
# All Rights Reserved - Do Not Redistribute
#

# Ensure apt is up to date
include_recipe 'apt' if platform_family?('debian')

# Install Apache2
include_recipe 'apache2'
include_recipe 'apache2::mod_dav_fs'
include_recipe 'apache2::mod_php5'
include_recipe 'apache2::mod_ssl'

apache_site 'default'
apache_site 'default-ssl'

# Install MySQL server
include_recipe 'mysql::server'

package 'php5-mysql' # TODO: Determine if this is necessary

# Download DVWA as an archive
remote_file "#{Chef::Config[:file_cache_path]}/#{node[:dvwa][:zip_name]}" do
  source node[:dvwa][:url]
end

# Unarchive DVWA and move contents into node[:dvwa][:dir] (which defaults to
#   /var/www)
package 'unzip'
bash 'install DVWA from zip' do
  code <<-eos
    unzip -q -o #{Chef::Config[:file_cache_path]}/#{node[:dvwa][:zip_name]} -d #{node[:dvwa][:dir]}
  eos

  # OPTIMIZE: Is it necessary to restart Apache2 immediately?
  notifies :restart, 'service[apache2]', :immediately
end

template "#{node[:dvwa][:dir]}/dvwa/config/config.inc.php" do
  variables :database_flavor => node[:dvwa][:database_flavor],
            :db => node[:dvwa][:db],
            :default_security_level => node[:dvwa][:default_security_level],
            :recaptcha => node[:dvwa][:recaptcha]
end

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
