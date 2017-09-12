module EtcdCookbook
  class EtcdServiceManagerSystemd < EtcdServiceBase
    resource_name :etcd_service_manager_systemd

    provides :etcd_service_manager, os: 'linux' do |_node|
      Chef::Platform::ServiceHelpers.service_resource_providers.include?(:systemd)
    end

    property :service_timeout, Integer, default: 20

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

      # Needed for Debian / Ubuntu
      directory '/usr/libexec' do
        owner 'root'
        group 'root'
        mode '0755'
        action :create
      end

      # cleanup the old systemd unit file
      file "/lib/systemd/system/#{etcd_name}.service" do
        action :delete
      end

      systemd_contents = {
        Unit: {
          Description: 'Etcd Application Container Engine',
          Documentation: 'https://coreos.com/etcd',
          After: 'network.target',
        },
        Service: {
          Type: 'notify',
          ExecStart: etcd_cmd,
          Restart: 'always',
          RestartSec: '10s',
          LimitNOFILE: '1048576',
          LimitNPROC: '1048576',
          LimitCORE: 'infinity',
        },
        Install: {
          WantedBy: 'multi-user.target',
        },
      }

      systemd_contents[:Service][:User] = new_resource.run_user if new_resource.run_user
      systemd_contents[:Service][:Environment] = "HTTP_PROXY=#{new_resource.http_proxy}" if new_resource.http_proxy
      systemd_contents[:Service][:Environment] = "HTTPS_PROXY=#{new_resource.https_proxy}" if new_resource.https_proxy
      systemd_contents[:Service][:Environment] = "NO_PROXY=#{new_resource.no_proxy}" if new_resource.no_proxy

      systemd_unit "#{etcd_name}.service" do
        content(systemd_contents)
        action :create
        notifies :restart, new_resource unless ::File.exist? "/etc/#{etcd_name}-firstconverge"
        notifies :restart, new_resource if new_resource.auto_restart
      end

      file "/etc/#{etcd_name}-firstconverge" do
        action :create
      end

      # service management resource
      service etcd_name do
        provider Chef::Provider::Service::Systemd
        supports status: true
        action [:enable, :start]
      end
    end

    action :stop do
    end

    action :restart do
      action_stop
      action_start
    end

    action_class do
      include EtcdHelpers::Service
    end
  end
end
