# frozen_string_literal: true

etcd_service 'default' do
  action [:create, :start]
end
