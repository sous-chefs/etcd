#
# Installs etcd from released tarballs
#


# assemble default url or use supplied url in attributes
# we can assemble the url from the version
#
version = node[:etcd][:version]
package = "etcd-v#{version}-#{node[:os].capitalize}.tar.gz"
package_url = "https://github.com/coreos/etcd/releases/download/v#{version}/#{package}"
if node[:etcd][:url]
  package_url = node[:etcd][:url]
end

ark "etcd" do
  has_binaries [ "etcd", "etcdctl" ]
  version node[:etcd][:version]
  url package_url
  checksum node[:etcd][:sha256]
  action :install
end
