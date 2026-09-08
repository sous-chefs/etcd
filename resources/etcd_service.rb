# frozen_string_literal: true

provides :etcd_service
unified_mode true
use '_partial/_common'

# installation type and service_manager
property :install_method,
          %w(binary auto docker none),
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

property :source,
          String,
          desired_state: false

action :create do
  installation :create
end

action :delete do
  svc_manager :delete
  installation :delete
end

action :start do
  svc_manager :start
end

action :stop do
  svc_manager :stop
end

action :restart do
  svc_manager :restart
end

action_class do
  def installation(requested_action)
    return if new_resource.install_method == 'none'

    type = { 'auto' => :etcd_installation, 'binary' => :etcd_installation_binary, 'docker' => :etcd_installation_docker }.fetch(new_resource.install_method)
    dispatch(type, requested_action)
  end

  def svc_manager(requested_action)
    type = { 'auto' => :etcd_service_manager, 'systemd' => :etcd_service_manager_systemd, 'docker' => :etcd_service_manager_docker }.fetch(new_resource.service_manager)
    dispatch(type, requested_action)
  end

  def dispatch(type, requested_action)
    source_resource = new_resource
    declare_resource(type, new_resource.name) do
      shared = self.class.properties.keys & source_resource.class.properties.keys
      copy_properties_from(source_resource, *shared, exclude: [:name, :action])
      action requested_action
    end
  end
end
