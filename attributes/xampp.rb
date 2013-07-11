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
  default[:dvwa][:dir] = "#{node[:xampp][:dir]}/lampp/htdocs"
  node.set[:xampp][:security_policies] = [
                                           'Order deny,allow',
                                           'Allow from all',
                                           'Allow from ::1 127.0.0.0/8 \
                                           fc00::/7 10.0.0.0/8 172.16.0.0/12 192.168.0.0/16 \
                                           fe80::/10 169.254.0.0/16',
                                           'ErrorDocument 403 /error/XAMPP_FORBIDDEN.html.var'
                                         ]
  # REVIEW: Should we just set this to %w[dvwa]?
  node.set[:xampp][:match_paths] = %w[dvwa xampp security licenses phpmyadmin webalizer server-status server-info]
end
