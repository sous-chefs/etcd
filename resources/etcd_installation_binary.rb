# frozen_string_literal: true

provides :etcd_installation_binary
provides :etcd_installation
unified_mode true
use '_partial/_common'

property :checksum, String, default: lazy { default_checksum }, desired_state: false
property :source, String, default: lazy { default_source }, desired_state: false

property :architecture, String, default: lazy { node['kernel']['machine'] == 'aarch64' ? 'arm64' : 'amd64' }, desired_state: false

action :create do
  package 'tar'

  remote_file tarball_path do
    source new_resource.source
    checksum new_resource.checksum
  end

  %w(etcd etcdctl etcdutl).each do |binary|
    next if binary == 'etcdutl' && !etcdutl_supported?

    execute "extract #{binary}" do
      command ['tar', 'xzf', tarball_path, '-C', etcd_bin_prefix, "etcd-v#{new_resource.version}-linux-#{new_resource.architecture}/#{binary}", '--strip-components=1']
      not_if do
        path = "#{etcd_bin_prefix}/#{binary}"
        flag = binary == 'etcd' ? '--version' : 'version'
        ::File.exist?(path) && shell_out!(path, flag).stdout.match?(/(?:etcd Version:|etcdctl version:|etcdutl version:) #{Regexp.escape(new_resource.version)}(?:\s|$)/i)
      end
    end
  end
end

action :delete do
  %w(etcd etcdctl etcdutl).each do |binary|
    file "#{etcd_bin_prefix}/#{binary}" do
      action :delete
    end
  end

  file tarball_path do
    action :delete
  end
end

def tarball_path
  "#{file_cache_path}/etcd-v#{version}-linux-#{architecture}.tar.gz"
end

def file_cache_path
  Chef::Config[:file_cache_path]
end

def default_source
  "https://github.com/etcd-io/etcd/releases/download/v#{version}/etcd-v#{version}-linux-#{architecture}.tar.gz"
end

def default_checksum
  if architecture == 'arm64'
    return 'd7e25e08f694b6ed7792fc7b7a891fe2c3f3d3dccfe2f3bfdb1547b0eb75b6da' if version == '3.7.1'
    raise ArgumentError, 'Supply checksum for this etcd version on arm64'
  end
  case version
  when '3.7.1' then 'e8cd3fa8064c98137c5dbd78b76f969417ace84efb83c481041d7a52ffdd8fb9'
  when '3.6.6' then '887afaa4a99f22d802ccdfbe65730a5e79aa5c9ce2c8799c67e9d804c50ecedb'
  when '3.5.21' then 'adddda4b06718e68671ffabff2f8cee48488ba61ad82900e639d108f2148501c'
  when '3.4.6' then 'a591b59639aed73061281d34720725ed47092705f68c7b11e0b6965044d4f7f6'
  when '3.3.19' then '9c9220002fb176f4d73492f78cab37c9bd8b5132b3ac6f14515629603518476d'
  when '3.2.17' then '0a75e794502e2e76417b19da2807a9915fa58dcbf0985e397741d570f4f305cd'
  when '3.2.15' then 'dff8ae43c49d8c21f9fc1fe5507cc2e86455994ac706b7d92684f389669462a9'
  when '3.2.14' then 'f77398f558ff19b65a0bf978b47868e03683f27090c56c054415666b1d78bf42'
  when '3.2.6' then '8186aa554c3eddfa16880fecc27f70bf24b57560d9187679a09331af651ea59c'
  end
end

def etcdutl_supported?
  Gem::Version.new(version) >= Gem::Version.new('3.5.0')
end

def etcd_bin_prefix
  '/usr/bin'
end

def etcd_bin
  "#{etcd_bin_prefix}/etcd"
end

def etcdctl_bin
  "#{etcd_bin_prefix}/etcdctl"
end

def etcdutl_bin
  "#{etcd_bin_prefix}/etcdutl"
end
