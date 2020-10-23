# binary installation for kitchen verify
etcd_installation_binary 'default'

docker_service 'default' do
  storage_driver 'vfs'
end

etcd_installation_docker 'default'

etcd_service_manager_docker 'default' do
  action :start
end
