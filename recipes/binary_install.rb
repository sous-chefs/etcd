# Encoding: UTF-8
# Installs etcd from released tarballs
#

# give the lib our node
Etcd.node = node

# ark needs tar, but doesn't ensure it's there (not there on cent cloud img)
# we should add it in at compile time
package 'tar' do
  action :nothing
end.run_action(:install)

ark 'etcd' do
  has_binaries ['etcd', 'etcdctl']
  version node[:etcd][:version]
  url Etcd.bin_url
  checksum node[:etcd][:sha256]
  action :install
end
