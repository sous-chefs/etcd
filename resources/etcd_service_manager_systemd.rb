# frozen_string_literal: true

provides :etcd_service_manager_systemd
provides :etcd_service_manager
unified_mode true
use '_partial/_common'

property :service_timeout, Integer, default: 120

action :start do
  user 'etcd' do
    system true
    only_if { new_resource.run_user == 'etcd' }
  end

  directory new_resource.data_dir do
    owner new_resource.run_user
    mode '0700'
    recursive true
  end

  if new_resource.wal_dir
    directory new_resource.wal_dir do
      owner new_resource.run_user
      mode '0700'
      recursive true
    end
  end

  file "/lib/systemd/system/#{etcd_name}.service" do
    action :delete
  end

  file "/etc/#{etcd_name}-firstconverge" do
    action :delete
  end

  systemd_contents = {
    Unit: {
      Description: 'etcd distributed key-value store',
      Documentation: 'https://etcd.io',
      After: 'network.target',
    },
    Service: {
      Type: 'notify',
      ExecStart: etcd_cmd,
      User: new_resource.run_user,
      Restart: 'always',
      RestartSec: '10s',
      LimitNOFILE: '1048576',
      LimitNPROC: '1048576',
      LimitCORE: 'infinity',
      TimeoutStartSec: new_resource.service_timeout.to_s,
    },
    Install: {
      WantedBy: 'multi-user.target',
    },
  }
  environment = []
  environment << "HTTP_PROXY=#{new_resource.http_proxy}" if new_resource.http_proxy
  environment << "HTTPS_PROXY=#{new_resource.https_proxy}" if new_resource.https_proxy
  environment << "NO_PROXY=#{new_resource.no_proxy}" if new_resource.no_proxy
  systemd_contents[:Service][:Environment] = environment unless environment.empty?

  systemd_unit "#{etcd_name}.service" do
    content systemd_contents
    action [:create, :enable, :start]
    ignore_failure new_resource.ignore_failure
    notifies :restart, "systemd_unit[#{etcd_name}.service]", :delayed if new_resource.auto_restart
  end
end

action :stop do
  systemd_unit "#{etcd_name}.service" do
    action :stop
  end
end

action :restart do
  systemd_unit "#{etcd_name}.service" do
    action :restart
  end
end

action :delete do
  systemd_unit "#{etcd_name}.service" do
    action [:stop, :disable, :delete]
    only_if { ::File.exist?("/etc/systemd/system/#{etcd_name}.service") || ::File.exist?("/lib/systemd/system/#{etcd_name}.service") }
  end

  ["/lib/systemd/system/#{etcd_name}.service", "/etc/#{etcd_name}-firstconverge", logfile, new_resource.config_file].compact.each do |path|
    file path do
      action :delete
    end
  end

  [new_resource.data_dir, new_resource.wal_dir].compact.uniq.each do |path|
    directory path do
      recursive true
      action :delete
    end
  end
end

action_class do
  include EtcdCookbook::EtcdHelpers::Service
end
