module EtcdCookbook
  class EtcdServiceManagerSysvinit < EtcdServiceBase
    resource_name :etcd_service_manager_sysvinit
    provides :etcd_service_manager, platform: 'amazon'

    provides :etcd_service_manager, platform: %w(redhat centos scientific oracle) do |node| # ~FC005
      node['platform_version'].to_f <= 7.0
    end

    provides :etcd_service_manager, platform: 'suse'
    provides :etcd_service_manager, platform: 'debian'

    action :start do
      user 'etcd' do
        action :create
        only_if { run_user == 'etcd' }
      end

      file logfile do
        owner run_user
        action :create
      end

      directory data_dir do
        owner run_user
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

    action_class.class_eval do
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
            etcd_name: etcd_name
          )
          action :create
          notifies :restart, new_resource
        end
      end

      def create_service
        service etcd_name do
          provider Chef::Provider::Service::Init::Redhat if platform_family?('rhel')
          provider Chef::Provider::Service::Init::Debian if platform_family?('debian')
          supports restart: true, status: true
          action [:enable, :start]
        end
      end
    end
  end
end
