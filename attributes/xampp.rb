#
# Cookbook Name:: dvwa
# Attributes:: xampp
#
# Copyright (c) 2012-2013, Rapid7
#
# All Rights Reserved - Do Not Redistribute
#

if node.run_list.include?('dvwa::xampp')
  include_attribute 'xampp'
  default[:dvwa][:dir] = "#{node[:xampp][:dir]}/lampp/htdocs/dvwa"
end
