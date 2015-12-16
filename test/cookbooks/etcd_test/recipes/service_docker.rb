# HACK: for kitchen-verify
etcd_installation_binary 'default'

#
docker_service 'default'

etcd_installation_docker 'default'

etcd_service_manager_docker 'default' do
  action :start
end
