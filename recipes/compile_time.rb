# Encoding: UTF-8
#
# Install, configure, and start etcd in one go @ compile time
#

# Etcd singleton gets our node
Etcd.node = node

include_recipe 'chef-sugar'

compile_time do
  include_recipe 'etcd::default'
end
