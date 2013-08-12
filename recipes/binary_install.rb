#
# Installs etcd from released tarballs
#

ark "etcd" do
  has_binaries [ "etcd", "etcdctl" ]
  url node[:etcd][:url]
  checksum node[:etcd][:sha256]
  action :install
end
