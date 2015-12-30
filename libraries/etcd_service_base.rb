module EtcdCookbook
  class EtcdServiceBase < EtcdBase
    ################
    # Helper Methods
    ################

    require_relative 'helpers_service'
    include EtcdHelpers::Service

    #####################
    # resource properties
    #####################

    resource_name :etcd_service
    provides :etcd_service_manager

    # https://coreos.com/etcd/docs/latest/configuration.html
    # Member flags
    property :node_name, String, name_property: true, desired_state: false
    property :data_dir, String, default: lazy { "#{node_name}.etcd" }, desired_state: false
    property :wal_dir, String, desired_state: false
    property :snapshot_count, String, desired_state: false
    property :heartbeat_interval, String, desired_state: false
    property :election_timeout, String, desired_state: false
    property :listen_peer_urls, String, desired_state: false
    property :listen_client_urls, String, desired_state: false
    property :max_snapshots, String, desired_state: false
    property :max_wals, String, desired_state: false
    property :cors, String, desired_state: false

    # Clustering Flags
    property :initial, String, desired_state: false
    property :initial_advertise_peer_urls, String, desired_state: false
    property :initial_cluster, String, desired_state: false
    property :initial_cluster_state, String, desired_state: false
    property :initial_cluster_token, String, desired_state: false
    property :advertise_client_urls, String, desired_state: false
    property :discovery, String, desired_state: false
    property :discovery_srv, String, desired_state: false
    property :discovery_fallback, String, desired_state: false
    property :discovery_proxy, String, desired_state: false

    # Proxy Flags
    property :proxy, String, desired_state: false
    property :proxy_failure_wait, String, desired_state: false
    property :proxy_refresh_interval, String, desired_state: false
    property :proxy_dial_timeout, String, desired_state: false
    property :proxy_write_timeout, String, desired_state: false
    property :proxy_read_timeout, String, desired_state: false

    # Security Flags
    property :cert_file, String, desired_state: false
    property :key_file, String, desired_state: false
    property :client_cert_auth, Boolean, default: false, desired_state: false
    property :trusted_ca_file, String, desired_state: false
    property :peer_cert_file, String, desired_state: false
    property :peer_key_file, String, desired_state: false
    property :peer_client_cert_auth, Boolean, default: false, desired_state: false
    property :peer_trusted_ca_file, String, desired_state: false

    # Logging Flags
    property :debug, Boolean, default: false, desired_state: false

    # Unsafe Flags
    property :force_new_cluster, Boolean, default: false, desired_state: false

    # Experimental Flags
    property :experimental_v3demo, Boolean, default: false, desired_state: false

    # Misc
    property :run_user, String, default: 'etcd', desired_state: false
    property :http_proxy, [String, nil], desired_state: false
    property :https_proxy, [String, nil], desired_state: false
    property :no_proxy, [String, nil], desired_state: false
    property :auto_restart, Boolean, default: false, desired_state: false
  end
end
