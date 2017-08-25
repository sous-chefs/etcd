docker_service 'default'

etcd_installation_docker 'default' do
  version '3.2.6'
  action :create
end
