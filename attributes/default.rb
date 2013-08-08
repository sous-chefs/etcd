#
# If you are seting up a clustere of etcd's
# set your seed node (first cluster node here)
default[:etcd][:seed_node] = nil
default[:etcd][:install_method] = "binary"
# more args ?
default[:etcd][:extra_args] = ""

# my build of etcd Aug, 08 2013
default[:etcd][:url] = "https://dl.dropboxusercontent.com/u/848501/etcd"
default[:etcd][:port] = 4001
default[:etcd][:raft_port] = 7001
default[:etcd][:bin] = "/usr/bin/etcd"
default[:etcd][:state_dir] = "/var/cache/etcd/state"
