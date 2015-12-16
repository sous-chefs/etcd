module EtcdCookbook
  class EtcdInstallationBinary < ChefCompat::Resource
    resource_name :etcd_installation_binary
    provides :etcd_installation

    #####################
    # resource properties
    #####################

    property :checksum, String, default: lazy { default_checksum }, desired_state: false
    property :source, String, default: lazy { default_source }, desired_state: false
    property :version, String, default: '2.2.2', desired_state: false

    default_action :create

    #########
    # actions
    #########

    action :create do
      remote_file 'etcd tarball' do
        path "#{file_cache_path}/etcd-v#{new_resource.version}-linux-amd64.tar.gz"
        source new_resource.source
        action :create
      end

      execute 'extract etcd' do
        command extract_etcd_cmd
        action :nothing
        subscribes :run, 'remote_file[etcd tarball]'
      end

      execute 'extract etcdctl' do
        command extract_etcdctl_cmd
        action :nothing
        subscribes :run, 'remote_file[etcd tarball]'
      end
    end

    action :delete do
      file etcd_bin do
        action :delete
      end

      file etcdctl_bin do
        action :delete
      end
    end

    ################
    # helper methods
    ################

    def file_cache_path
      Chef::Config[:file_cache_path]
    end

    def default_source
      "https://github.com/coreos/etcd/releases/download/v#{version}/etcd-v#{version}-linux-amd64.tar.gz"
    end

    def default_checksum
      case version
      when '2.2.2' then '90aff7364caa43932fd46974825af20e0ecb70fe7e01981e2d3a496106f147e7'
      end
    end

    def etcd_bin
      "#{etcd_bin_prefix}/etcd"
    end

    def etcd_bin_prefix
      '/usr/bin'
    end

    def etcdctl_bin
      "#{etcdctl_bin_prefix}/etcdctl"
    end

    def etcdctl_bin_prefix
      etcd_bin_prefix
    end

    def extract_etcd_cmd
      "tar xvf #{file_cache_path}/etcd-v#{version}-linux-amd64.tar.gz -C #{etcd_bin_prefix} etcd-v#{version}-linux-amd64/etcd --strip-components=1"
    end

    def extract_etcdctl_cmd
      "tar xvf #{file_cache_path}/etcd-v#{version}-linux-amd64.tar.gz -C #{etcdctl_bin_prefix} etcd-v#{version}-linux-amd64/etcdctl --strip-components=1"
    end
  end
end
