#
# Cookbook Name:: dvwa
# Attributes:: default
#
# Copyright (c) 2012-2013, Rapid7
#
# All Rights Reserved - Do Not Redistribute
#

# NOTE: Raises a NotImplementedError for now
default[:dvwa][:database_flavor] = 'MySQL'
default[:dvwa][:db] = {}
default[:dvwa][:db][:name] = 'dvwa'
default[:dvwa][:db][:server] = '127.0.0.1'

# Used by the PGSQL DB flavor
default[:dvwa][:db][:port] = 5432
default[:dvwa][:db][:user] = 'root'
default[:dvwa][:default_security_level] = 'low'
default[:dvwa][:dir] = "/var/www"
default[:dvwa][:flavor] = :standalone
default[:dvwa][:recaptcha] = {}
default[:dvwa][:version] = '1.0.7'

default[:dvwa][:zip_name] = "DVWA-#{node[:dvwa][:version]}.zip"
default[:dvwa][:url] = "http://downloads.sourceforge.net/project/dvwa/#{node[:dvwa][:zip_name]}"
