# Encoding: UTF-8
# Installs etcd from released tarballs
#

# give the lib our node
Etcd.node = node

ark 'etcd' do
  has_binaries ['etcd', 'etcdctl']
  version node[:etcd][:version]
  url Etcd.bin_url
  checksum node[:etcd][:sha256]
  action :install
end
