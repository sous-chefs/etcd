module EtcdCookbook
  class EtcdKey < ChefCompat::Resource
    require 'etcd'

    resource_name :etcd_key

    property :key, String, name_property: true, desired_state: false
    property :value, String
    property :ttl, String, desired_state: false
    property :host, String, default: '127.0.0.1', desired_state: false
    property :port, Integer, default: 2379, desired_state: false

    def etcd
      @etcd ||= ::Etcd.client(host: host, port: port)
    end

    def key_exist?
      true if etcd.get(key)
    rescue Etcd::KeyNotFound
      false
    end

    load_current_value do
      value etcd.get(key).value if key_exist?
    end

    action :set do
      if current_resource.value != value
        opts = { value: value }
        opts[:ttl] = ttl if ttl
        converge_by "will set value of key #{key}" do
          etcd.set(key, opts)
        end
      end
    end

    action :delete do
      if key_exist? # ~FC023
        converge_by "delete key #{key}" do
          etcd.delete(key)
        end
      end
    end

    action :watch do
      converge_by "watching for updates of #{key}" do
        etcd.watch(key)
      end
    end
  end
end
