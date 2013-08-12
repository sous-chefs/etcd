#
# If you are seting up a clustere of etcd's
# set your seed node (first cluster node here)
default[:etcd][:seed_node] = nil
default[:etcd][:install_method] = "binary"

# more args ?
default[:etcd][:extra_args] = ""

# url to the release, and sha256 sum
default[:etcd][:url] = "https://github.com/coreos/etcd/releases/download/v0.1.0/etcd-v0.1.0-Linux.tar.gz"
default[:etcd][:sha256] = "0089111a4c36e8d481efb91e847dbf498c4db2e33c43a1103fa8fb77f904dcb0"

default[:etcd][:port] = 4001
default[:etcd][:raft_port] = 7001
default[:etcd][:bin] = "/usr/local/bin/etcd"
default[:etcd][:state_dir] = "/var/cache/etcd/state"
