require 'Resolv'

class Chef::Recipe::Resolver
    # We can call this with ISP.vhosts
    def self.ip(hostname)
        Resolv.getaddress hostname
    end
end
