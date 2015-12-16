module EtcdCookbook
  class EtcdInstallationDocker < ChefCompat::Resource
    resource_name :etcd_installation_docker

    #####################
    # resource properties
    #####################

    property :repo, String, default: 'quay.io/coreos/etcd', desired_state: false
    property :tag, default: lazy { "v#{version}" }, desired_state: false
    property :version, default: '2.2.2'

    default_action :create

    #########
    # actions
    #########

    action :create do
      docker_image 'etcd' do
        repo new_resource.repo
        tag new_resource.tag
        action :pull
      end
    end

    action :delete do
      docker_image 'etcd' do
        repo new_resource.repo
        tag new_resource.tag
        action :remove
      end
    end
  end
end
