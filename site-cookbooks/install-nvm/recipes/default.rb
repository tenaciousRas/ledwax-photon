#
# Cookbook Name:: install-nvm
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

# install nvm
include_recipe 'nvm'

nvm_install node['nvm']['version']  do
  from_source node['nvm']['from_source']
  alias_as_default node['nvm']['alias_as_default']
  action :create
end
