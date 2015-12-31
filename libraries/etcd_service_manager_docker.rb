module EtcdCookbook
  class EtcdServiceManagerDocker < EtcdServiceBase
    resource_name :etcd_service_manager_docker

    property :repo, String, default: 'quay.io/coreos/etcd'
    property :tag, default: lazy { "v#{version}" }
    property :version, default: '2.2.2', desired_state: false
    property :container_name, String, default: lazy { etcd_name }, desired_state: false
    property :port, default: ['2379/tcp4:2379', '4001/tcp4:4001']
    property :network_mode, String, default: 'host'

    action :start do
      docker_container container_name do
        repo new_resource.repo
        tag new_resource.tag
        command etcd_daemon_opts.join(' ').strip
        port new_resource.port
        network_mode new_resource.network_mode
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
  end
end
