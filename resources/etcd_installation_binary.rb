resource_name :etcd_installation_binary
provides :etcd_installation

#####################
# resource properties
#####################

property :checksum, String, default: lazy { default_checksum }, desired_state: false
property :source, String, default: lazy { default_source }, desired_state: false
property :version, String, default: '3.2.15', desired_state: false

default_action :create

#########
# actions
#########

action :create do
  package 'tar'

  remote_file 'etcd tarball' do
    path "#{file_cache_path}/etcd-v#{new_resource.version}-linux-amd64.tar.gz"
    source new_resource.source
    checksum new_resource.checksum
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
  when '3.2.15' then 'dff8ae43c49d8c21f9fc1fe5507cc2e86455994ac706b7d92684f389669462a9'
  when '3.2.14' then 'f77398f558ff19b65a0bf978b47868e03683f27090c56c054415666b1d78bf42'
  when '3.2.6' then '8186aa554c3eddfa16880fecc27f70bf24b57560d9187679a09331af651ea59c'
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
