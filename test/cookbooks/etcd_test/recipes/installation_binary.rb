etcd_installation_binary 'default' do
  version node['etcd']['version']
  action :create
end
