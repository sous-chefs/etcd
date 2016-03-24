module EtcdCookbook
  class EtcdInstallationDocker < ChefCompat::Resource
    resource_name :etcd_installation_package

    action :create do
      case node[:platform]
      when 'centos'
        package 'etcd'
      else
        Chef::Exceptions::UnsupportedPlatform
      end
    end

    action :delete do
      case node[:platform]
      when 'centos'
        package 'etcd' do
          action :purge
        end
      else
        Chef::Exceptions::UnsupportedPlatform
      end
    end
  end
end
