include EtcdCookbook::EtcdCommonProperties

resource_name :etcd_service_manager_sysvinit
provides :etcd_service_manager, os: 'linux'

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

  create_init
  create_service
end

action :stop do
  create_init
  s = create_service
  s.action :stop
end

action :restart do
  action_stop
  action_start
end

action_class do
  include EtcdCookbook::EtcdHelpers::Service

  def create_init
    template "/etc/init.d/#{etcd_name}" do
      source 'sysvinit/etcd.erb'
      owner 'root'
      group 'root'
      mode '0755'
      cookbook 'etcd'
      variables(
        config: new_resource,
        etcd_bin: etcd_bin,
        etcd_cmd: etcd_cmd,
        etcdctl_cmd: etcdctl_cmd,
        etcd_daemon_opts: etcd_daemon_opts,
        etcd_name: etcd_name,
        logfile: logfile
      )
      action :create
      notifies :restart, new_resource
    end
  end

  def create_service
    service etcd_name do
      provider Chef::Provider::Service::Init::Redhat if platform_family?('rhel', 'amazon')
      provider Chef::Provider::Service::Init::Debian if platform_family?('debian')
      supports restart: true, status: true
      ignore_failure true if new_resource.ignore_failure
      action [:enable, :start]
    end
  end
end
