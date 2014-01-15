#
default[:etcd][:install_method] = "binary"

# cluster options
default[:etcd][:seed_node] = nil

# if you wrap this cookbook you should use your wrappers cook name here
default[:etcd][:search_cook] = "etcd"

# set to false if you don't want environment scoped searching
default[:etcd][:env_scope] = true

# Readable name to give to etcd node
default[:etcd][:name_switch] = node[:hostname]

# service start args to pass
default[:etcd][:args] = " -addr #{ipaddress}:4001 -peer-addr #{ipaddress}:7001"

# nodes in cluster
default[:etcd][:nodes] = []

# Activate snapshoting
default[:etcd][:snapshot] = false

# Allow locally
default[:etcd][:local] = true

# restart etcd when the config file is updated
default[:etcd][:trigger_restart] = true

# Release to install
default[:etcd][:version] = "0.2.0"
# Sha for github tarball Linux by default
default[:etcd][:sha256] = "726bd35e67e643436e21b3a8f3433ecf4419dabbca337c481c81117095c166ab"
# Use this to supply your own url to a tarball
default[:etcd][:url] = nil

default[:etcd][:state_dir] = "/var/cache/etcd/state"

# Used for source_install method
default[:etcd][:source][:repo] = "https://github.com/coreos/etcd"
default[:etcd][:source][:revision] = "HEAD"
default[:etcd][:source][:go_ver] = "1.1.2"
default[:etcd][:source][:go_url] = nil
default[:etcdctl][:source][:repo] = "https://github.com/coreos/etcdctl"
default[:etcdctl][:source][:revision] = "HEAD"
