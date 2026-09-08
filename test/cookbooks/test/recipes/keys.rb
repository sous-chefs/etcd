# frozen_string_literal: true

etcd_service 'default' do
  action [:create, :start]
end

etcd_key '/test' do
  value 'a_test_value'
end

execute 'seed key for deletion' do
  command ['/usr/bin/etcdctl', 'put', '/delete', 'delete']
  creates '/marker_etcd_key_delete'
end

file '/marker_etcd_key_delete'

etcd_key '/delete' do
  action :delete
end

etcd_key '/leased' do
  value 'temporary'
  ttl 300
end
