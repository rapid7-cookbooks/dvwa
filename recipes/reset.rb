#
# Cookbook Name:: dvwa
# Recipe:: reset
#
# Copyright (c) 2013, Rapid7
#
# All Rights Reserved - Do Not Redistribute
#

include_recipe 'dvwa::up'

# TODO: Ensure the HTTP request resource works like the following curl command:
# curl --data 'create_db=Create+%2F+Reset+Database' http://localhost/dvwa/setup.php# --cookie PHPSESSID=1
#
http_request "create/reset database" do
  action :post
  url 'http://localhost/dvwa/setup.php'
  message :create_db => 'Create+%2F+Reset+Database'
  headers({:PHPSESSID => 1})
end
