etcd_service 'default' do
  action [:create, :start]
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
