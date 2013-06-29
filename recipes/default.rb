#
# Cookbook Name:: dvwa
# Recipe:: default
#
# Copyright (c) 2012-2013, Rapid7
#
# All Rights Reserved - Do Not Redistribute
#

case node[:dvwa][:flavor]
when :xampp
  include_recipe 'dvwa::xampp'
when :apache2, :server, :standalone
  include_recipe 'dvwa::standalone'
end
