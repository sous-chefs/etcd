etcd_installation_binary 'default' do
  action :create
end

etcd_service_manager_systemd 'default' do
  default_service_name true
  action :start
end
