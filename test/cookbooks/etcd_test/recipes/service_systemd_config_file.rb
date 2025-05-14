etcd_installation_binary 'default' do
  action :create
end

etcd_service_manager_systemd 'default' do
  config_file '/etc/etcd/etcd-default.conf.yml'
  listen_peer_urls 'http://localhost:2380'
  listen_client_urls 'http://localhost:2379'
  action :start
end
