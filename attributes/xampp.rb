#
# Cookbook Name:: dvwa
# Attributes:: xampp
#
# Copyright (c) 2012-2013, Rapid7
#
# All Rights Reserved - Do Not Redistribute
#

include_attribute 'xampp'

default[:dvwa][:dir] = "#{node[:xampp][:dir]}/lampp/htdocs"
default[:dvwa][:version] = '1.0.7'
default[:dvwa][:zip_name] = "DVWA-#{node[:dvwa][:version]}.zip"
default[:dvwa][:url] = "http://downloads.sourceforge.net/project/dvwa/#{node[:dvwa][:zip_name]}"
