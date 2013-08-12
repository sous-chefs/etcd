#
# If you are seting up a clustere of etcd's
# set your seed node (first cluster node here)
default[:etcd][:seed_node] = nil
default[:etcd][:install_method] = "binary"

# more args ?
default[:etcd][:extra_args] = ""

# Release to install
default[:etcd][:version] = "0.1.0"
# Sha for github tarball
default[:etcd][:sha256] = "0089111a4c36e8d481efb91e847dbf498c4db2e33c43a1103fa8fb77f904dcb0"
# Use this to supply your own url to a tarball
default[:etcd][:url] = nil

default[:etcd][:port] = "0.0.0.0:4001"
default[:etcd][:raft_port] = "0.0.0.0:7001"
default[:etcd][:state_dir] = "/var/cache/etcd/state"
