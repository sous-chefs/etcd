etcd_installation_binary 'default' do
  action :create
  version '3.3.19'
end

etcd_service_manager_systemd 'default' do
  action :start
end

etcd_key '/test' do
  value 'a_test_value'
end

execute 'etcdctl set /delete delete' do
  not_if { ::File.exist?('/marker_etcd_key_delete') }
end

file '/marker_etcd_key_delete' do
  action :create
end

etcd_key '/delete' do
  action :delete
end
