module EtcdCookbook
  class EtcdServiceConfFile < EtcdServiceBase
    resource_name :etcd_service_conffile

    provides :etcd_service_manager, platform: 'centos'

    action :create do
      # Create service template
      template "/lib/systemd/system/etcd.service" do
        source 'systemd/etcd.service.conffile.erb'
        owner 'root'
        group 'root'
        mode '0644'
        variables(
          config: new_resource,
          etcd_name: etcd_name,
          etcd_bin: etcd_bin
        )
        cookbook 'etcd'
        notifies :run, 'execute[systemctl daemon-reload]', :immediately
        notifies :restart, new_resource if auto_restart
        action :create
      end

      # Register this service within Chef
      service 'etcd' do
        supports restart: true, status: true
        action [:enable]
      end

      # Create config file
      template "/etc/etcd/#{etcd_name}.conf" do
        cookbook 'etcd'
        source 'etcd.conf.erb'
        owner 'root'
        group 'root'
        mode '0755'
        notifies :restart, new_resource if auto_restart
        variables config: new_resource
      end

      # Avoid 'Unit file changed on disk' warning
      execute 'systemctl daemon-reload' do
        command '/bin/systemctl daemon-reload'
        action :nothing
      end
    end

    action :start do
      service etcd_name do
        action [:start]
      end
    end

    action :stop do
    end

    action :restart do
      action_stop
      action_start
    end
  end
end
