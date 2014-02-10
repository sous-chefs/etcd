#
# Etcd Helper Libraries
#
#
class Chef::Recipe::Etcd
  class << self
    attr_accessor :slave, :node

    #
    # Compute weather we are peer or discovery
    #
    def args
      args  = node[:etcd][:args]
      discovery =  node[:etcd][:discovery]

      if node[:etcd][:local] == true
        args << " -bind-addr 0.0.0.0 -peer-bind-addr 0.0.0.0"
      end

      if discovery.length > 0
        args << " -discovery='#{discovery}'"
      elsif slave  == true
        args << " -peers-file=/etc/etcd_members"
      end
      args
    end


    #
    # lookup github url
    #
    def gh_bin_url
      version = node[:etcd][:version]

      case version
      when "0.3.0"
        package = "etcd-v#{version}-#{node[:os]}-amd64.tar.gz"
      else
        package = "etcd-v#{version}-#{node[:os].capitalize}-x86_64.tar.gz"
      end

       "https://github.com/coreos/etcd/releases/download/v#{version}/#{package}"
     end

  end
end
