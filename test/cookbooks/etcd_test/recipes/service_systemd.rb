#

etcd_installation_binary 'default' do
  action :create
end

etcd_service_manager_systemd 'default' do
  action :start
end
