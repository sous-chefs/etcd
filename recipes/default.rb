# recipe:: Default
#
# Setup etcd

case node[:etcd][:install_method]
when "binary"
  include_recipe "etcd::binary_install"
when "source"
  include_recipe "etcd::source_install"
else
  log "Install Method not supported: #{node[:etcd][:install_method]}" do
    level :fatal
  end
end

include_recipe "etcd::_service"
