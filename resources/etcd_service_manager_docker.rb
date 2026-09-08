# frozen_string_literal: true

provides :etcd_service_manager_docker
unified_mode true
use '_partial/_common'

property :repo,
          String,
          default: 'quay.io/coreos/etcd'

property :tag,
          String,
          default: lazy { "v#{version}" }

property :container_name,
          String,
          default: lazy { |n| "etcd-#{n.node_name}" },
          desired_state: false

property :port,
          Array,
          default: ['2379/tcp4:2379', '2380/tcp4:2380']

property :network_mode,
          String,
          default: 'host'

property :host_data_path,
          String,
          default: lazy { "/var/lib/etcd/#{node_name}" }

action :start do
  etcd_data_dir = ::File.absolute_path(new_resource.data_dir, '/')

  directory new_resource.host_data_path do
    recursive true
    mode '0700'
  end

  docker_container new_resource.container_name do
    repo new_resource.repo
    tag new_resource.tag
    command "etcd #{etcd_daemon_opts.join(' ').strip}"
    port new_resource.port
    network_mode new_resource.network_mode
    volumes "#{new_resource.host_data_path}:#{etcd_data_dir}"
    action :run
  end
end

action :stop do
  docker_container new_resource.container_name do
    action :stop
  end
end

action :restart do
  docker_container new_resource.container_name do
    action :restart
  end
end

action :delete do
  docker_container new_resource.container_name do
    action [:stop, :delete]
  end

  directory new_resource.host_data_path do
    recursive true
    action :delete
  end
end

action_class do
  include EtcdCookbook::EtcdHelpers::Service
end
