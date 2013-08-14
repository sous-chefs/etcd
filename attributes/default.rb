#
default[:etcd][:install_method] = "binary"

# cluster options
default[:etcd][:seed_node] = nil

# if you wrap this cookbook you should use your wrappers cook name here
default[:etcd][:search_cook] = "etcd"

# service start args to pass
default[:etcd][:args] = " -c 0.0.0.0:4001 -s 0.0.0.0:7001"

# Release to install
default[:etcd][:version] = "0.1.0"
# Sha for github tarball
default[:etcd][:sha256] = "0089111a4c36e8d481efb91e847dbf498c4db2e33c43a1103fa8fb77f904dcb0"
# Use this to supply your own url to a tarball
default[:etcd][:url] = nil

default[:etcd][:state_dir] = "/var/cache/etcd/state"
