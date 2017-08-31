# ChefSpec is a tool to unit test cookbooks in conjunction with rspec
# Learn more on the README or at https://github.com/sethvargo/chefspec.
if defined?(ChefSpec)
  ChefSpec.define_matcher(:etcd_installation)
  ChefSpec.define_matcher(:etcd_installation_binary)
  ChefSpec.define_matcher(:etcd_installation_docker)
  ChefSpec.define_matcher(:etcd_key)
  ChefSpec.define_matcher(:etcd_service)
  ChefSpec.define_matcher(:etcd_service_manager)
  ChefSpec.define_matcher(:etcd_service_manager_docker)
  ChefSpec.define_matcher(:etcd_service_manager_systemd)
  ChefSpec.define_matcher(:etcd_service_manager_sysvinit)
  ChefSpec.define_matcher(:etcd_service_manager_upstart)

  def create_etcd_installation(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:etcd_installation, :create, resource_name)
  end

  def delete_etcd_installation(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:etcd_installation, :delete, resource_name)
  end

  def create_etcd_installation_binary(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:etcd_installation_binary, :create, resource_name)
  end

  def delete_etcd_installation_binary(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:etcd_installation_binary, :delete, resource_name)
  end

  def create_etcd_installation_docker(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:etcd_installation_docker, :create, resource_name)
  end

  def delete_etcd_installation_docker(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:etcd_installation_docker, :delete, resource_name)
  end

  def set_etcd_key(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:etcd_key, :set, resource_name)
  end

  def delete_etcd_key(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:etcd_key, :delete, resource_name)
  end

  def watch_etcd_key(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:etcd_key, :watch, resource_name)
  end

  def create_etcd_service(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:etcd_service, :create, resource_name)
  end

  def delete_etcd_service(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:etcd_service, :delete, resource_name)
  end

  def start_etcd_service(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:etcd_service, :start, resource_name)
  end

  def stop_etcd_service(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:etcd_service, :stop, resource_name)
  end

  def restart_etcd_service(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:etcd_service, :restart, resource_name)
  end

  def start_etcd_service_manager(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:etcd_service_manager, :start, resource_name)
  end

  def stop_etcd_service_manager(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:etcd_service_manager, :stop, resource_name)
  end

  def restart_etcd_service_manager(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:etcd_service_manager, :restart, resource_name)
  end

  def start_etcd_service_manager_docker(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:etcd_service_manager_docker, :start, resource_name)
  end

  def stop_etcd_service_manager_docker(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:etcd_service_manager_docker, :stop, resource_name)
  end

  def restart_etcd_service_manager_docker(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:etcd_service_manager_docker, :restart, resource_name)
  end

  def start_etcd_service_manager_systemd(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:etcd_service_manager_systemd, :start, resource_name)
  end

  def stop_etcd_service_manager_systemd(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:etcd_service_manager_systemd, :stop, resource_name)
  end

  def restart_etcd_service_manager_systemd(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:etcd_service_manager_systemd, :restart, resource_name)
  end

  def start_etcd_service_manager_sysvinit(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:etcd_service_manager_sysvinit, :start, resource_name)
  end

  def stop_etcd_service_manager_sysvinit(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:etcd_service_manager_sysvinit, :stop, resource_name)
  end

  def restart_etcd_service_manager_sysvinit(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:etcd_service_manager_sysvinit, :restart, resource_name)
  end

  def start_etcd_service_manager_upstart(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:etcd_service_manager_upstart, :start, resource_name)
  end

  def stop_etcd_service_manager_upstart(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:etcd_service_manager_upstart, :stop, resource_name)
  end

  def restart_etcd_service_manager_upstart(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:etcd_service_manager_upstart, :restart, resource_name)
  end
end
