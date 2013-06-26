#
# Cookbook Name:: dvwa
# Recipe:: down
#
# Copyright (c) 2013, Rapid7
#
# All Rights Reserved - Do Not Redistribute
#

include_recipe 'dvwa::install'
include_recipe 'xampp::down'
