
class Chef::Recipe
  def etcd_peers_arg
    if node[:etcd][:discovery].length > 0
      " -discovery='#{node[:etcd][:discovery]}'"
    elsif node.run_state.has_key? :etcd_slave and
      node.run_state[:etcd_slave] == true
      " -peers-file=/etc/etcd_members"
    else
      ""
    end
  end
end
