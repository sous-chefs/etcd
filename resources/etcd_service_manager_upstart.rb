include EtcdCookbook::EtcdCommonProperties

resource_name :etcd_service_manager_upstart

provides :etcd_service_manager, platform_family: 'debian' do |_node|
  Chef::Platform::ServiceHelpers.service_resource_providers.include?(:upstart) &&
    !Chef::Platform::ServiceHelpers.service_resource_providers.include?(:systemd)
end

# Start the service
action :start do
  user 'etcd' do
    action :create
    only_if { new_resource.run_user == 'etcd' }
  end

  file logfile do
    owner new_resource.run_user
    action :create
  end

  directory new_resource.data_dir do
    owner new_resource.run_user
    action :create
  end

  template "/etc/init/#{etcd_name}.conf" do
    source 'upstart/etcd.conf.erb'
    owner 'root'
    group 'root'
    mode '0644'
    variables(
      config: new_resource,
      etcd_name: etcd_name,
      etcd_cmd: etcd_cmd,
      logfile: logfile
    )
    cookbook 'etcd'
    notifies :restart, new_resource unless ::File.exist? "/etc/#{etcd_name}-firstconverge"
    notifies :restart, new_resource if new_resource.auto_restart
    action :create
  end

  file "/etc/#{etcd_name}-firstconverge" do
    action :create
  end

  service etcd_name do
    provider Chef::Provider::Service::Upstart
    supports status: true
    action :start
    ignore_failure true if new_resource.ignore_failure
  end
end

action :stop do
  service etcd_name do
    provider Chef::Provider::Service::Upstart
    supports status: true
    action :stop
  end
end

action :restart do
  action_stop
  action_start
end

action_class do
  include EtcdCookbook::EtcdHelpers::Service
end
