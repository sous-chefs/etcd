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
      if node[:etcd][:local] == true
        ' -bind-addr 0.0.0.0 -peer-bind-addr 0.0.0.0'
      else
        ''
      end
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

    def lookup_addr(option, key = '', port)
      cmd = ''
      if key.match(/.*:(\d)/)
        cmd << " #{option}=#{key}"
      elsif key.length > 0
        cmd << " #{option}=#{key}:#{port}"
      end
      cmd
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

    # when you specify args in config we don't compute. so you have to specify all of them
    #
    def args
      # return node[:etcd][:args] if node[:etcd][:args].length > 0
      cmd = node[:etcd][:args].dup
      cmd << local_cmd
      cmd << node_name
      cmd << discovery_cmd
      cmd << lookup_addr('-peer-addr', node[:etcd][:peer_addr], 7001)
      cmd << lookup_addr('-addr', node[:etcd][:peer_addr], 4001)
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
