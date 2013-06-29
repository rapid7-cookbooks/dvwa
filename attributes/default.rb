#
# Cookbook Name:: dvwa
# Attributes:: default
#
# Copyright (c) 2012-2013, Rapid7
#
# All Rights Reserved - Do Not Redistribute
#

default[:dvwa][:db_name] = 'dvwa'
default[:dvwa][:default_security_level] = 'low'
default[:dvwa][:dir] = "/var/www"
default[:dvwa][:flavor] = :standalone
default[:dvwa][:version] = '1.0.7'
default[:dvwa][:zip_name] = "DVWA-#{node[:dvwa][:version]}.zip"
default[:dvwa][:url] = "http://downloads.sourceforge.net/project/dvwa/#{node[:dvwa][:zip_name]}"
