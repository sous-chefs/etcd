module EtcdCookbook
  require 'etcd_service_base'
  class EtcdService < EtcdServiceBase
    # register with the resource resolution system
    resource_name :etcd_service
    # default_action :create

    # installation type and service_manager
    property :install_method, %w(binary auto docker), default: 'auto', desired_state: false
    property :service_manager, %w(execute sysvinit upstart systemd auto docker), default: 'auto', desired_state: false

    # etcd_installation_binary
    property :checksum, String, desired_state: false
    property :etcd_bin, String, desired_state: false
    property :source, String, desired_state: false
    property :version, String, desired_state: false

    ################
    # Helper Methods
    ################

    def copy_properties_to(to, *properties)
      properties = self.class.properties.keys if properties.empty?
      properties.each do |p|
        # If the property is set on from, and exists on to, set the
        # property on to
        if to.class.properties.include?(p) && property_is_set?(p)
          to.send(p, send(p))
        end
      end
    end

    action_class.class_eval do
      def installation(&block)
        case install_method
        when 'auto'
          install = etcd_installation(name, &block)
        when 'binary'
          install = etcd_installation_binary(name, &block)
        when 'none'
          Chef::Log.info('Skipping Etcd installation. Assuming it was handled previously.')
          return
        end
        copy_properties_to(install)
        install
      end

      def svc_manager(&block)
        case service_manager
        when 'auto'
          svc = etcd_service_manager(name, &block)
        when 'execute'
          svc = etcd_service_manager_execute(name, &block)
        when 'sysvinit'
          svc = etcd_service_manager_sysvinit(name, &block)
        when 'upstart'
          svc = etcd_service_manager_upstart(name, &block)
        when 'systemd'
          svc = etcd_service_manager_systemd(name, &block)
        end
        copy_properties_to(svc)
        svc
      end
    end

    #########
    # Actions
    #########

    action :create do
      installation do
        action :create
        # notifies :restart, new_resource
      end
    end

    action :delete do
      installation do
        action :delete
      end
    end

    action :start do
      svc_manager do
        action :start
      end
    end

    action :stop do
      svc_manager do
        action :stop
      end
    end

    action :restart do
      svc_manager do
        action :restart
      end
    end
  end
end
