# Encoding: UTF-8
#
# Etcd Helper Libraries
#
#
class Chef::Recipe::Etcd
  # intent of this class is recipe helpers
  # for usage with etcd cook
  class << self
    attr_accessor :slave, :node

    # return local cmdline args if localmode
    def local_cmd
      ' -bind-addr 0.0.0.0 -peer-bind-addr 0.0.0.0' if node[:etcd][:local] == true
    end

    # return cmd args for discovery/cluster members
    def discovery_cmd
      discovery =  node[:etcd][:discovery]
      cmd = ''
      if discovery.length > 0
        cmd << " -discovery='#{discovery}'"
      elsif slave  == true
        cmd << ' -peers-file=/etc/etcd_members'
      end
      cmd
    end

    def peer_addr
      cmd = ''
      if node[:etcd][:peer_addr].match(/.*:(\d)/)
        cmd << " --peer-addr=#{node[:etcd][:peer_addr]}"
      elsif node[:etcd][:peer_addr].length > 0
        cmd << " --peer-addr=#{node[:etcd][:peer_addr]}:7001"
      end
    end

    def snapshot
      " -snapshot=#{node[:etcd][:snapshot]}"
    end

    # determine node name
    def node_name
      a = " -name #{node.name}"
      a = " -name #{node[:fqdn]}" unless node[:fqdn].nil?
      a = " -name #{node[:etcd][:name]}" unless node[:etcd][:name].nil?
      a
    end

    #
    # Compute weather we are peer or discovery
    # rubocop:disable MethodLength
    def args
      cmd = node[:etcd][:args].dup
      cmd << local_cmd
      cmd << node_name
      cmd << discovery_cmd
      cmd << peer_addr
      cmd << snapshot
      cmd
    end
    # rubocop:endable MethodLength

    #
    # compute the package name based on etcd version
    #
    def package_name
      version = node[:etcd][:version]

      if Gem::Requirement.new('>= 0.3.0').satisfied_by?(Gem::Version.new(version))
        "etcd-v#{version}-#{node[:os]}-amd64.tar.gz"
      else
        "etcd-v#{version}-#{node[:os].capitalize}-x86_64.tar.gz"
      end
    end

    #
    # Return URL for package via what user has supplied of what we compute
    #
    def bin_url
      version = node[:etcd][:version]
      if  node[:etcd][:url]
        node[:etcd][:url]
      else
        "https://github.com/coreos/etcd/releases/download/v#{version}/#{package_name}"
      end
    end
  end
end
