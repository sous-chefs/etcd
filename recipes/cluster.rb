# Encoding: UTF-8
# Cookbook:: etcd
#  Reecipe:: cluster
#
# This sets up a set of servers via search or attributes or discover
# TODO: Much of this recipe should be moved to lib/helper methods.
#
#-------------------------------------------------------------------------------
require 'resolv'

# pass node over to Etcd singleton
Etcd.node = node

# make sure we validate
if node[:etcd][:discovery].length > 0
  include_recipe 'etcd'
  return
end

msg = '`node[:etcd][:seed_node]` is required to bootstrap a cluster'
log msg do
  level :error
  not_if { node[:etcd][:seed_node] }
end

# Hostnames and/or ip addresses of current node
my_ip = ::Resolv.getaddress(node[:fqdn]) || ::Resolv.getaddress(node[:hostname]) || ::Resolv.getaddress(node.name)
my_hostnames = [
  node[:fqdn],
  node[:hostname],
  node.name,
  my_ip
]

log "Seed node is : #{node[:etcd][:seed_node]}"
log "Setting up etcd::cluster. Hosts are : #{my_hostnames.join ', '}"

# if we aren't the seed then include initial cluster bootstrap
unless my_hostnames.include? node[:etcd][:seed_node]
  log 'This node is a slave node'
  Etcd.slave = true
end

cluster = node[:etcd][:nodes].dup
if node[:etcd][:nodes].empty? && Chef::Config[:solo] != true
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

log 'Etcd got cluster: ' << cluster.inspect do
  level :debug
end

# Build /etc/etcd_members file
# rubocop:disable MultilineBlockChain
cluster_str = cluster.sort.select do |n|
  # Filter out current host
  !my_hostnames.include? n
end.map do |hostname|
  # Get IP address
  # TODO: break this thing up, this could break if unresolvable
  ::Resolv.getaddress hostname
end.map do |ip|
  # Append port
  "#{ip}:7001"
end.join ','  # Join in one string
# rubocop:enable MultilineBlockChain

log "Setting up etcd members: #{cluster_str}"
# write out members
file '/etc/etcd_members' do
  content cluster_str
end

include_recipe 'etcd'
