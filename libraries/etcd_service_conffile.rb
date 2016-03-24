module EtcdCookbook
  class EtcdServiceConfFile < EtcdServiceBase
    resource_name :etcd_service_conffile

    provides :etcd_service_manager, platform: 'centos'

    action :create do
      service 'etcd' do
        supports restart: true, status: true
        action [:enable]
      end

      template "/etc/etcd/etcd.conf" do
        cookbook 'etcd'
        source 'etcd.conf.erb'
        owner 'root'
        group 'root'
        mode '0755'
        notifies :restart, 'service[etcd]'
        variables config: new_resource
      end
    end
  end
end
