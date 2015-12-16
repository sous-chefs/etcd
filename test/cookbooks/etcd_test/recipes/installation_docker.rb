docker_service 'default'

etcd_installation_docker 'default' do
  version node['etcd']['version']
  action :create
end
