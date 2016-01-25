etcd_service 'default' do
  action [:create, :start]
end

chef_gem "etcd" do
  compile_time true
end

etcd_key "/test" do
  value "a_test_value"
end

execute "etcdctl set /delete delete"

etcd_key "/delete" do
  action :delete
end

