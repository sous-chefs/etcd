# Encoding: UTF-8
default[:etcd][:install_method] = 'binary'

# address to announce to peers specified as ip:port or ip (will default to :7001)
default[:etcd][:peer_addr] = ''

# the adress that etcd uses publically. if not set we compute it to node.ipaddress:4001
default[:etcd][:addr] = ''

# set if you want to override the node name. It uses fqdn by default
default[:etcd][:name] = nil

# cluster options
default[:etcd][:seed_node] = nil

# if you wrap this cookbook you should use your wrappers cook name here
default[:etcd][:search_cook] = 'etcd\:\:cluster'

# set to false if you don't want environment scoped searching
default[:etcd][:env_scope] = true

# service start args to pass
default[:etcd][:args] = ''

# v0.3.0 API cluster discovery
default[:etcd][:discovery] = ''

# nodes in cluster
default[:etcd][:nodes] = []

# Activate snapshoting
default[:etcd][:snapshot] = true

# Allow locally
default[:etcd][:local] = true

# restart etcd when the config file is updated
default[:etcd][:trigger_restart] = true

# Upstart parameters for starting/stopping etcd service
default[:etcd][:upstart][:start_on] = 'started networking'
default[:etcd][:upstart][:stop_on] = 'shutdown'

# Release to install
default[:etcd][:version] = '0.4.2'

# Auto respawn
default[:etcd][:respawn] = false

# Sha for github tarball Linux by default
default[:etcd][:sha256] = '18be476ba59db42c573ee23fbe00f4a205830ac54f752c0d46280707603c9192'

# Use this to supply your own url to a tarball
default[:etcd][:url] = nil

default[:etcd][:state_dir] = '/var/cache/etcd/state'

# Used for source_install method
default[:etcd][:source][:repo] = 'https://github.com/coreos/etcd'
default[:etcd][:source][:revision] = 'HEAD'
default[:etcd][:source][:go_ver] = '1.1.2'
default[:etcd][:source][:go_url] = nil
default[:etcdctl][:source][:repo] = 'https://github.com/coreos/etcdctl'
default[:etcdctl][:source][:revision] = 'HEAD'
