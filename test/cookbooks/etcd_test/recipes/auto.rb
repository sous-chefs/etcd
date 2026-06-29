apt_update

etcd_service 'default' do
  action [:create, :start]
end
