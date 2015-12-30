# binary installation for simplicity

etcd_installation_binary 'default' do
  action :create
end

# https://coreos.com/etcd/docs/2.2.2/clustering.html
# Static Clustering

user 'alice'
user 'bob'
user 'eve'

directory '/etcd0.etcd' do
  owner 'alice'
  mode '0700'
end

directory '/etcd1.etcd' do
  owner 'bob'
  mode '0700'
end

directory '/etcd2.etcd' do
  owner 'eve'
  mode '0700'
end

etcd_service_manager_upstart 'etcd0' do
  advertise_client_urls 'http://127.0.0.1:2379,http://127.0.0.1:4001'
  listen_client_urls 'http://0.0.0.0:2379,http://0.0.0.0:4001'
  initial_advertise_peer_urls 'http://127.0.0.1:2380'
  listen_peer_urls 'http://0.0.0.0:2380'
  initial_cluster_token 'etcd-cluster-1'
  initial_cluster 'etcd0=http://127.0.0.1:2380,etcd1=http://127.0.0.1:3380,etcd2=http://127.0.0.1:4380'
  initial_cluster_state 'new'
  run_user 'alice'
  action :start
end

etcd_service_manager_upstart 'etcd1' do
  advertise_client_urls 'http://127.0.0.1:3379,http://127.0.0.1:5001'
  listen_client_urls 'http://0.0.0.0:3379,http://0.0.0.0:5001'
  initial_advertise_peer_urls 'http://127.0.0.1:3380'
  listen_peer_urls 'http://0.0.0.0:3380'
  initial_cluster_token 'etcd-cluster-1'
  initial_cluster 'etcd0=http://127.0.0.1:2380,etcd1=http://127.0.0.1:3380,etcd2=http://127.0.0.1:4380'
  initial_cluster_state 'new'
  run_user 'bob'
  action :start
end

etcd_service_manager_upstart 'etcd2' do
  advertise_client_urls 'http://127.0.0.1:4379,http://127.0.0.1:6001'
  listen_client_urls 'http://0.0.0.0:4379,http://0.0.0.0:6001'
  initial_advertise_peer_urls 'http://127.0.0.1:4380'
  listen_peer_urls 'http://0.0.0.0:4380'
  initial_cluster_token 'etcd-cluster-1'
  initial_cluster 'etcd0=http://127.0.0.1:2380,etcd1=http://127.0.0.1:3380,etcd2=http://127.0.0.1:4380'
  initial_cluster_state 'new'
  run_user 'eve'
  action :start
end
