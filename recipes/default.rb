#
# Cookbook Name:: dvwa
# Recipe:: default
#
# Copyright (c) 2012-2013, Rapid7
#
# All Rights Reserved - Do Not Redistribute
#

# OPTIMIZE
case "#{node[:dvwa][:flavor]}".to_sym
when :xampp
  include_recipe 'dvwa::xampp'
when :apache2, :server, :standalone
  include_recipe 'dvwa::standalone'
end
