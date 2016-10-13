require 'digest/sha2'

password = "password"
salt = rand(36**8).to_s(36)
shadow_hash = password.crypt("$6$" + salt)

username = node['postgresql']['install_user'] || "vagrant"
Chef::Log.info("Creating user '#{username}'")

# create user/group
group username do
  action :create
  name username
  gid '3333'
  append true
end

user username do
  comment 'postgresql user'
  uid '3333'
  gid username
  home "/home/#{username}"
  shell '/bin/bash'
  password shadow_hash
end

group "#{username}" do
  action :modify
  name username
  gid '3333'
  members "#{username}, vagrant"
  append true
end

# Fake /mnt/disk0/
directory '/var/lib/pgsql/9.4/' do
  recursive true
end

# Suppose we create new_datadir with correct permission
## Fake /mnt/disk0/psql_data
new_datadir = '/var/lib/pgsql/9.4/data'

# Disable auto-start
execute 'disable auto-start 1/2' do
  command 'echo exit 101 > /usr/sbin/policy-rc.d'
end

execute 'disable auto-start 2/2' do
  command 'chmod +x /usr/sbin/policy-rc.d'
end

# No restart
node.override['postgresql']['server']['config_change_notify'] = :reload
node.override['postgresql']['config']['data_directory'] = new_datadir

node['postgresql']['server']['packages'].each do |pg_pack|
  package pg_pack
end

directory new_datadir do
  owner username
  group username
  recursive true
end

# Create new cluster with new_datadir
execute 'create base database in data_directory' do
  user username
  command 'PATH=$PATH:/usr/lib/postgresql/' \
    "#{node['postgresql']['version']}/bin initdb " \
    "#{node['postgresql']['config']['data_directory']}"
  not_if do
    ::FileTest.exist?(
      File.join(node['postgresql']['config']['data_directory'], 'PG_VERSION')
    )
  end
end

include_recipe 'postgresql::apt_pgdg_postgresql'
include_recipe 'postgresql::client'
include_recipe 'postgresql::server'
