#
# Installs etcd from released tarballs
#


# assemble default url or use supplied url in attributes
# we can assemble the url from the version
#

url = gh_bin_url
if node[:etcd][:url]
  url = node[:etcd][:url]
end

ark "etcd" do
  has_binaries ["etcd", "etcdctl"]
  version node[:etcd][:version]
  url url
  checksum node[:etcd][:sha256]
  action :install
end
