module EtcdCookbook
  class EtcdServiceManagerUpstart < EtcdServiceBase
    resource_name :etcd_service_manager_upstart
    provides :etcd_service_manager, platform: 'ubuntu'

    action :start do
      template "/etc/init/#{etcd_name}.conf" do
        source 'upstart/etcd.conf.erb'
        owner 'root'
        group 'root'
        mode '0644'
        variables(
          config: new_resource,
          etcd_name: etcd_name,
          etcd_cmd: etcd_cmd
        )
        cookbook 'etcd'
        notifies :restart, new_resource unless ::File.exist? "/etc/#{etcd_name}-firstconverge"
        notifies :restart, new_resource if auto_restart
        action :create
      end

      file "/etc/#{etcd_name}-firstconverge" do
        action :create
      end

      service etcd_name do
        provider Chef::Provider::Service::Upstart
        supports status: true
        action :start
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
  end
end
