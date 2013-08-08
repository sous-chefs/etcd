# recipe:: Default
#
# Setup etcd

case node[:etcd][:install_method]
when "binary"
  include_recipe "etcd::binary_install"
else
  log "Install Method not supported for etcd yet: #{node[:etcd][:install_method]}" do
    level :warn
  end
end

include_recipe "etcd::_service"
