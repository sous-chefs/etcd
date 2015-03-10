# Encoding: UTF-8
#
# recipe:: Default
#
# Setup etcd

user node[:etcd][:user]

group node[:etcd][:user] do
  members node[:etcd][:user]
end

directory node[:etcd][:log_dir] do
  owner node[:etcd][:user]
  group node[:etcd][:group]
  mode '0755'
  only_if { node[:etcd][:log_to_file] }
end

case node[:etcd][:install_method]
when 'binary'
  include_recipe 'etcd::binary_install'
when 'source'
  include_recipe 'etcd::source_install'
else
  log "Install Method not supported: #{node[:etcd][:install_method]}" do
    level :fatal
  end
end

include_recipe 'etcd::_service'
