#
# Recipe:: _service
#
#

directory File.dirname node[:etcd][:state_dir]

args = node[:etcd][:bin]
args << " -c #{node[:etcd][:port]}"
args << " -s#{node[:etcd][:raft_port]} #{node[:etcd][:extra_args]}"
if node[:etcd][:seed_node]
  args << " -C #{node[:etcd][:seed_node]}"
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
