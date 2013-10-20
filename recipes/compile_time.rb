#
# Install, congigure, and start etcd in one go @ compile time
#


version = node[:etcd][:version]
package = "etcd-v#{version}-#{node[:os].capitalize}-x86_64.tar.gz"
url = "https://github.com/coreos/etcd/releases/download/v#{version}/#{package}"
if node[:etcd][:url]
  url = node[:etcd][:url]
end

# hack to get compile time installation
a = ark "etcd" do
  has_binaries ["etcd", "etcdctl"]
  version node[:etcd][:version]
  url url
  checksum node[:etcd][:sha256]
  action :install
end

a.run_action :install

directory File.dirname node[:etcd][:state_dir]

args = node[:etcd][:args]
if node.run_state.has_key? :etcd_slave  and node.run_state[:etcd_slave] == true
  args << " -CF=/etc/etcd_members"
end

t = template "/etc/init/etcd.conf" do
  mode 0644
  variables(args: args)
  notifies :restart, "service[etcd]", :immediately
end

s = service "etcd" do
  provider Chef::Provider::Service::Upstart
  supports :status => true, :restart => true, :reload => true
  action [:enable, :start]
end

t.run_action :create
s.run_action :start
