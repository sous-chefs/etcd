#
# Recipe:: _service
#
#

directory File.dirname node[:etcd][:state_dir]

args = node[:etcd][:args]

# Allow local access over port 4001
if node[:etcd][:local]
  args << " -bind-addr 0.0.0.0 -peer-bind-addr 0.0.0.0"
end

args << etcd_peers_arg

template "/etc/init/etcd.conf" do
  mode 0644
  variables(:args => args)
  notifies :restart, "service[etcd]" if node[:etcd][:trigger_restart]
end

service "etcd" do
  provider Chef::Provider::Service::Upstart
  supports :status => true, :restart => true, :reload => true
  action [:enable, :start]
end
