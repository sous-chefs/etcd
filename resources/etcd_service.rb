provides :etcd_service
unified_mode true
use 'partial/_common'

# installation type and service_manager
property :install_method,
          %w(binary auto docker),
          default: 'auto',
          desired_state: false

property :service_manager,
          %w(systemd auto docker),
          default: 'auto',
          desired_state: false

# etcd_installation_binary
property :checksum,
          String,
          desired_state: false

property :etcd_bin,
          String,
          desired_state: false

property :source,
          String,
          desired_state: false

property :version,
          String,
          desired_state: false

action :create do
  installation do
    action :create
  end
end

action :delete do
  installation do
    action :delete
  end
end

action :start do
  svc_manager do
    action :start
  end
end

action :stop do
  svc_manager do
    action :stop
  end
end

action :restart do
  svc_manager do
    action :restart
  end
end

action_class do
  def installation(&block)
    case new_resource.install_method
    when 'auto'
      install = etcd_installation(new_resource.name, &block)
    when 'binary'
      install = etcd_installation_binary(new_resource.name, &block)
    when 'none'
      Chef::Log.info('Skipping Etcd installation. Assuming it was handled previously.')
      return
    end
    install.copy_properties_from(new_resource, exclude: [:install_method])
    install
  end

  def svc_manager(&block)
    case new_resource.service_manager
    when 'auto'
      svc = etcd_service_manager(new_resource.name, &block)
    when 'systemd'
      svc = etcd_service_manager_systemd(new_resource.name, &block)
    end
    svc.copy_properties_from(new_resource, exclude: [:service_manager, :install_method])
    svc
  end
end
