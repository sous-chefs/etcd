# frozen_string_literal: true

# binary installation for kitchen verify
etcd_installation_binary 'default'

docker_service 'default' do
  storage_driver 'vfs'
  if platform_family?('suse')
    install_method 'package'
    package_name 'docker'
    setup_docker_repo false
  end
  package_options value_for_platform_family(
                    'rhel' => '--allowerasing', # dnf platforms
                    'debian' => "--force-yes -o Dpkg::Options::='--force-confold' -o Dpkg::Options::='--force-all'",
                    'default' => nil # anything else
                  )
end

etcd_installation_docker 'default'

etcd_service_manager_docker 'default' do
  action :start
end
