#
# Recipe:: _service
#
#

directory File.dirname node[:etcd][:state_dir]

args = node[:etcd][:args]
if node.run_state.has_key? :etcd_slave  and node.run_state[:etcd_slave] == true
  args << " -CF=/etc/etcd_members"
end

template "/etc/init/etcd.conf" do
  mode 0644
  variables(args: args)
end

service "etcd" do
  provider Chef::Provider::Service::Upstart
  supports :status => true, :restart => true, :reload => true
  action [:enable, :start]
end
