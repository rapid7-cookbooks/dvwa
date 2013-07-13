#
# Cookbook Name:: dvwa
# Attributes:: standalone
#
# Copyright (c) 2012-2013, Rapid7
#
# All Rights Reserved - Do Not Redistribute
#

if node.run_list.include?('dvwa::standalone')
  if node[:dvwa][:database_flavor].eql? 'MySQL'
    include_attribute 'mysql::server'

    default[:mysql][:bind_address] = '127.0.0.1'
    default[:mysql][:server_debian_password] = 'msfadmin'
    default[:mysql][:server_root_password] = 'msfadmin'
    default[:mysql][:server_repl_password] = 'msfadmin'

    default[:mysql][:mod_ssl][:cipher_suite] = 'LOW:HIGH:MEDIUM:+EXP:+SHA1:+MD5:+LOW:+HIGH:+MEDIUM'
    default[:mysql][:mod_ssl][:protocol] = '+all'

    default[:dvwa][:db][:password] = node[:mysql][:server_root_password]
  else
    raise NotImplementedError
  end
end
