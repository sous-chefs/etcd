docker_service 'default'

etcd_installation_docker 'default' do
  version '2.3.7'
  action :create
end
