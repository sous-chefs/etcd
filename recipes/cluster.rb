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
      :keys => {
        'node' => ['fqdn']
      }
    ).map do |n|
        # Return hostname/fqdn
        n['node']
    end
end

# Cleanup nodes
# had this in one statement, but might be simpler to break it out even more
cluster.map! { |n| [node[:fqdn], node[:hostname]].include?(n) ? nil : "#{n}:7001" }
cluster.compact!
cluster = cluster.join ","

# write out members
file "/etc/etcd_members" do
  content cluster
end

include_recipe "etcd"
