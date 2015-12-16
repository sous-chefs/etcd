#

etcd_installation_binary 'default' do
  action :create
end

etcd_service_manager_sysvinit 'default' do
  action :start
end
