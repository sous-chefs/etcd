#
# Cookbook:: etcd
#  Reecipe:: cluster
#
#
# Use search to find nodes that are in the eetcd cluster and build a -CF clusteer file for etcd
#

# make sure we validate
unless node[:etcd][:seed_node]
  log "Please set node[:etcd][:seed_node] to one of you're etcd systems to bootstrap the cluster" do
    level :error
  end
end

# if we aren't the seed then include initial cluster bootstrap
if node.name != node[:etcd][:seed_node]
  node.run_state[:etcd_slave] = true
end

#
# find nodes in this env and populate the cluster nodes file with it
query = "recipes:#{node[:etcd][:search_cook]}"
query << " AND chef_environment:#{node.chef_environment}" if node[:etcd][:env_scope]

# return a string of comma sepparated  fqdn that doens't include this host
cluster = partial_search(:node, query,
   :keys => { 'node' => [ 'fqdn' ] }
   ).map { |n| n['node'] == node[:hostname] ? nil : "#{n['node']}:7001" }.compact.join ","

# write out members
file "/etc/etcd_members" do
   content  cluster
end

include_recipe "etcd"
