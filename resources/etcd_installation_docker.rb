provides :etcd_installation_docker
unified_mode true

property :repo, String, default: 'quay.io/coreos/etcd', desired_state: false
property :tag, String, default: lazy { "v#{version}" }, desired_state: false
property :version, String, default: '3.2.15'

action :create do
  docker_image 'etcd' do
    repo new_resource.repo
    tag new_resource.tag
    action :pull
  end
end

action :delete do
  docker_image 'etcd' do
    repo new_resource.repo
    tag new_resource.tag
    action :remove
  end
end
