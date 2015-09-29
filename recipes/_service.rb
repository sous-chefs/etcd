# Encoding: UTF-8
# Recipe:: _service
#
#

## Handle Upstart/Init/Systemd properly
systemd = false
init = false
upstart = true
init_provider = Chef::Provider::Service::Upstart

if node[:init_package] == 'init'
  case node[:platform_family]
  when "rhel"
    init_provider = Chef::Provider::Service::Init::Redhat
  when "debian"
    init_provider = Chef::Provider::Service::Init::Debian
  end
  init = true
  upstart = false
end
if node[:init_package] == 'systemd'
  init_provider = Chef::Provider::Service::Systemd
  systemd = true
  upstart = false
end

directory File.dirname node[:etcd][:state_dir] do
  user node[:etcd][:user]
  group node[:etcd][:group]
  mode 0755
end

template '/etc/init.d/etcd' do
  mode 0755
  only_if { init }
end

init_args = Etcd.args.delete("'")
template '/etc/default/etcd' do
  mode 0644
  source 'etcd-default.erb'
  variables(args: init_args)
  notifies :restart, 'service[etcd]' if node[:etcd][:trigger_restart]
  only_if { init }
end

template '/etc/init/etcd.conf' do
  mode 0644
  variables(args: Etcd.args)
  notifies :restart, 'service[etcd]' if node[:etcd][:trigger_restart]
  only_if { upstart }
end

# TODO: use this on other sytemd platforms
template '/etc/systemd/system/etcd.service' do
  mode 0644
  variables(args: Etcd.args)
  notifies :run, 'execute[systemd_reload_units]', :immediate
  notifies :restart, 'service[etcd]' if node[:etcd][:trigger_restart]
  only_if { systemd }
end

execute 'systemd_reload_units' do
  action :nothing
  command '/bin/systemctl daemon-reload'
end

service 'etcd' do
  provider init_provider
  supports status: true, restart: true, reload: true
  action [:enable, :start] if node[:etcd][:trigger_start]
end
