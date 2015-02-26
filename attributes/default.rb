# Encoding: UTF-8
default[:etcd][:install_method] = 'binary'

# the default http protocol to use 
default[:etcd][:http_protocol] = 'http://'

# address to announce to peers specified as ip:port or ip (will default to :7001)
default[:etcd][:listen_peer_urls] = ''

# address to announce to clients specified as ip:port or ip (will default to :7001)
default[:etcd][:listen_client_urls] = ''

# List of URLs to listen on for peer traffic. if not set we compute it to http://localhost:2380,http://localhost:7001
default[:etcd][:initial_advertise_peer_urls] = ''

# List of URLs to listen on for client traffic. if not set we compute it to http://localhost:2379,http://localhost:4001
default[:etcd][:advertise_client_urls] = ''

# set if you want to override the node name. It uses fqdn by default
default[:etcd][:name] = ''

# if you wrap this cookbook you should use your wrappers cook name here
default[:etcd][:search_cook] = 'etcd\:\:cluster'

# set to false if you don't want environment scoped searching
default[:etcd][:env_scope] = true

# service start args to pass
default[:etcd][:args] = ''

# v0.3.0 API cluster discovery
default[:etcd][:discovery] = ''

# v0.3.0 API cluster discovery dns srv records
default[:etcd][:discovery_srv] = ''

# Initial cluster configuration for bootstrapping
default[:etcd][:initial_cluster] = ''

# Initial cluster state ("new" or "existing").
default[:etcd][:initial_cluster_state] = 'new'

# restart etcd when the config file is updated
default[:etcd][:trigger_restart] = true

# start etcd when etcd is first installed
default[:etcd][:trigger_start] = true

# Upstart parameters for starting/stopping etcd service
default[:etcd][:upstart][:start_on] = 'started networking'
default[:etcd][:upstart][:stop_on] = 'shutdown'

# Release to install
default[:etcd][:version] = '2.0.3'

# Auto respawn
default[:etcd][:respawn] = false

# Sha for github tarball Linux by default
default[:etcd][:sha256] = '0d4dd3ec5c3961433f514544ae7106676f313fe2fa7aa85cde0f2454f1a65b2f'

# Use this to supply your own url to a tarball
default[:etcd][:url] = nil

# Etcd's backend storage
default[:etcd][:state_dir] = '/var/cache/etcd/state'

# Used for source_install method
default[:etcd][:source][:repo] = 'https://github.com/coreos/etcd'
default[:etcd][:source][:revision] = 'HEAD'
default[:etcd][:source][:go_ver] = '1.1.2'
default[:etcd][:source][:go_url] = nil
default[:etcdctl][:source][:repo] = 'https://github.com/coreos/etcdctl'
default[:etcdctl][:source][:revision] = 'HEAD'

# Create user and group for etcd
default[:etcd][:user] = 'etcd'
default[:etcd][:group] = 'etcd'
