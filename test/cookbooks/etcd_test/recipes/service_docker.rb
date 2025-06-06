# binary installation for kitchen verify
etcd_installation_binary 'default'

docker_service 'default' do
  storage_driver 'vfs'
  package_options value_for_platform_family(
                    %w(rhel fedora) => '--allowerasing', # dnf platforms
                    'debian'        => "--force-yes -o Dpkg::Options::='--force-confold' -o Dpkg::Options::='--force-all'",
                    'default'       => nil               # anything else
                  )
end

etcd_installation_docker 'default'

etcd_service_manager_docker 'default' do
  action :start
end
