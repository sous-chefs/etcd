include EtcdCookbook::EtcdCommonProperties

resource_name :etcd_service_manager_docker

property :repo, String, default: 'quay.io/coreos/etcd'
property :tag, default: lazy { "v#{version}" }
property :version, default: '3.2.15', desired_state: false
property :container_name, String, default: lazy { |n| "etcd-#{n.node_name}" }, desired_state: false
property :port, default: ['2379/tcp4:2379', '2380/tcp4:2380']
property :network_mode, String, default: 'host'
property :host_data_path, String, default: '/var/lib/etcd'

action :start do
  etcd_data_dir = ::File.absolute_path(new_resource.data_dir, '/')

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
  docker_container container_name do
    action [:stop, :delete]
  end
end

action :restart do
  action_stop
  action_start
end

action_class do
  include EtcdCookbook::EtcdHelpers::Service
end
