#
# Cookbook:: etcd
#  Reecipe:: cluster
#
#
# Use search to find nodes that are in the eetcd cluster and build a -CF clusteer file for etcd
#

# make sure we validate
msg="`node[:etcd][:seed_node]` is required to bootstrap a cluster"
log msg do
  level :error
  not_if { node[:etcd][:seed_node] }
end

# if we aren't the seed then include initial cluster bootstrap
if node.name != node[:etcd][:seed_node]
  node.run_state[:etcd_slave] = true
end

#
# find nodes in this env and populate the cluster nodes file with it
query = "recipes:#{node[:etcd][:search_cook]}"


if node[:etcd][:env_scope]
  query << " AND chef_environment:#{node.chef_environment}"
end

# return a string of comma sepparated  fqdn that doens't include this host
cluster = partial_search(:node, query,
  :keys => {
    'node' => ['fqdn']
  }
)
# had this in one statement, but might be simpler to break it out even more
cluster.map! { |n| n['node'] == node[:fqdn] ? nil : "#{n['node']}:7001" }
cluster.compact!
cluster = cluster.join ","

# write out members
file "/etc/etcd_members" do
  content cluster
end

include_recipe "etcd"
