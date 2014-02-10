#
# Recipe:: _service
#
#

directory File.dirname node[:etcd][:state_dir]

template "/etc/init/etcd.conf" do
  mode 0644
  variables(:args => Etcd.args)
  notifies :restart, "service[etcd]" if node[:etcd][:trigger_restart]
end

service "etcd" do
  provider Chef::Provider::Service::Upstart
  supports :status => true, :restart => true, :reload => true
  action [:enable, :start]
end
