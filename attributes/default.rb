#
default[:etcd][:install_method] = "binary"

# cluster options
default[:etcd][:seed_node] = nil

# if you wrap this cookbook you should use your wrappers cook name here
default[:etcd][:search_cook] = "etcd"

# set to false if you don't want environment scoped searching
default[:etcd][:env_scope] = true

# service start args to pass
default[:etcd][:args] = " -c #{ipaddress}:4001 -s #{ipaddress}:7001"

# Release to install
default[:etcd][:version] = "0.1.2"
# Sha for github tarball
default[:etcd][:sha256] = "2bc03993559333649455aadcd0f0b1f16aa4dddf30188171741fcaf0d4fd8a55"
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
