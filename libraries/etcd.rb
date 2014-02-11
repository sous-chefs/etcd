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

    #
    # Compute weather we are peer or discovery
    # rubocop:disable MethodLength
    def args
      args  = node[:etcd][:args]
      discovery =  node[:etcd][:discovery]

      if node[:etcd][:local] == true
        args << ' -bind-addr 0.0.0.0 -peer-bind-addr 0.0.0.0'
      end

      if discovery.length > 0
        args << " -discovery='#{discovery}'"
      elsif slave  == true
        args << ' -peers-file=/etc/etcd_members'
      end
      args
    end
    # rubocop:endable MethodLength

    # compute the package name based on etcd version
    def package_name
      version = node[:etcd][:version]

      package = case version
      when '0.3.0'
        "etcd-v#{version}-#{node[:os]}-amd64.tar.gz"
      else
        "etcd-v#{version}-#{node[:os].capitalize}-x86_64.tar.gz"
      end
      package
    end

    #
    # Return URL for package via what user has supplied of what we compute
    #
    def bin_url
      version = node[:etcd][:version]
      if  node[:etcd][:url]
        url = node[:etcd][:url]
      else
        url = "https://github.com/coreos/etcd/releases/download/v#{version}/#{package_name}"
      end
    end
  end
end
