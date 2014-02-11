# Encoding: UTF-8
# Cookbook:: etcd
#  Reecipe:: cluster
#
# This sets up a set of servers via search or attributes or discover
#-------------------------------------------------------------------------------

require 'resolv'

# pass node over to Etcd singleton
Etcd.node = node

# make sure we validate
if node[:etcd][:discovery].length > 0 then
  log 'Use discovery URL to gather the peers'
else
  msg = '`node[:etcd][:seed_node]` is required to bootstrap a cluster'
  log msg do
    level :error
    not_if { node[:etcd][:seed_node] }
  end

  # Hostnames and/or ip addresses of current node
  my_ip = Resolv.getaddr(node[:fqdn]) || Resolv.getaddr(node[:hostname]) || Resolv.getaddr(node[:name])
  self_hostnames = [
    node[:fqdn],
    node[:hostname],
    node[:name],
    my_ip
  ]

  log "Seed node is : #{node[:etcd][:seed_node]}"
  log "Setting up etcd::cluster. Hosts are : #{self_hostnames.join ', '}"

  # if we aren't the seed then include initial cluster bootstrap
  unless self_hostnames.include? node[:etcd][:seed_node]
    log 'This node is a slave node'
    Etcd.slave = true
  else
    log 'This node will be the seed node'
  end

  if Chef::Config[:solo]
    Chef::Log.warn 'etcd requires node[:etcd][:nodes] to be set when using Chef Solo !'

    # Else simply use specified nodes in :nodes array
    cluster = node[:etcd][:nodes].dup
  else
    # find nodes in this env and populate the cluster nodes file with it
    query = "recipes:#{node[:etcd][:search_cook]}"

    if node[:etcd][:env_scope]
      query << " AND chef_environment:#{node.chef_environment}"
    end

    # Get a list of hosts
    cluster = partial_search(:node, query,
                             keys: {
                               'node' => ['fqdn']
                             }
    ).map do |n|
      # Return hostname/fqdn
      n['node']
    end
  end

  # Build /etc/etcd_members file
  cluster_str = cluster.select do |n|
    # Filter out current host
    not self_hostnames.include? n
  end.map do |hostname|
    # Get IP address
    Resolve.getaddress hostname
  end.map do |ip|
    # Append port
    "#{ip}:7001"
  end.join ','  # Join in one string

  # write out members
  file '/etc/etcd_members' do
    content cluster_str
  end
end

include_recipe 'etcd'
