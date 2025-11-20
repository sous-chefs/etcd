# Set default service name like etcd.service

property :default_service_name,
          [true, false],
          default: false

property :version,
          String,
          default: '3.6.6',
          desired_state: false

# https://coreos.com/etcd/docs/latest/configuration.html
# Member flags
property :node_name,
          String,
          name_property: true,
          desired_state: false

property :data_dir,
          String,
          default: lazy { "/#{node_name}.etcd" },
          desired_state: false

property :wal_dir,
          String,
          desired_state: false

property :snapshot_count,
          String,
          desired_state: false

property :heartbeat_interval,
          String,
          desired_state: false

property :election_timeout,
          String,
          desired_state: false

property :listen_peer_urls,
          String,
          desired_state: false

property :listen_client_urls,
          String,
          desired_state: false

property :max_snapshots,
          String,
          desired_state: false

property :max_wals,
          String,
          desired_state: false

property :cors,
          String,
          desired_state: false

property :quota_backend_bytes,
          String,
          desired_state: false

# Clustering Flags
property :initial,
          String,
          desired_state: false

property :initial_advertise_peer_urls,
          String,
          desired_state: false

property :initial_cluster,
          String,
          desired_state: false

property :initial_cluster_state,
          String,
          desired_state: false

property :initial_cluster_token,
          String,
          desired_state: false

property :advertise_client_urls,
          String,
          desired_state: false

property :discovery,
          String,
          desired_state: false

property :discovery_srv,
          String,
          desired_state: false

property :discovery_fallback,
          String,
          desired_state: false

property :discovery_proxy,
          String,
          desired_state: false

# Discovery v3 Flags (etcd 3.6+)
property :discovery_token,
          String,
          desired_state: false

property :discovery_endpoints,
          String,
          desired_state: false

property :discovery_dial_timeout,
          String,
          desired_state: false

property :discovery_request_timeout,
          String,
          desired_state: false

property :discovery_keepalive_time,
          String,
          desired_state: false

property :discovery_keepalive_timeout,
          String,
          desired_state: false

property :discovery_insecure_transport,
          [true, false],
          default: true,
          desired_state: false

property :discovery_insecure_skip_tls_verify,
          [true, false],
          default: false,
          desired_state: false

property :discovery_cert,
          String,
          desired_state: false

property :discovery_key,
          String,
          desired_state: false

property :discovery_cacert,
          String,
          desired_state: false

property :discovery_user,
          String,
          desired_state: false

property :discovery_password,
          String,
          desired_state: false

property :strict_reconfig_check,
          [true, false],
          default: false,
          desired_state: false

property :auto_compaction_retention,
          String,
          default: '0',
          desired_state: false

property :enable_v2,
          [true, false],
          default: true,
          desired_state: false

# Proxy Flags
property :proxy,
          String,
          desired_state: false

property :proxy_failure_wait,
          String,
          desired_state: false

property :proxy_refresh_interval,
          String,
          desired_state: false

property :proxy_dial_timeout,
          String,
          desired_state: false

property :proxy_write_timeout,
          String,
          desired_state: false

property :proxy_read_timeout,
          String,
          desired_state: false

# Security Flags
property :cert_file,
          String,
          desired_state: false

property :key_file,
          String,
          desired_state: false

property :client_cert_auth,
          [true, false],
          default: false,
          desired_state: false

property :trusted_ca_file,
          String,
          desired_state: false

property :auto_tls,
          [true, false],
          default: false,
          desired_state: false

property :peer_cert_allowed_cn,
          String,
          desired_state: false

property :peer_cert_file,
          String,
          desired_state: false

property :peer_key_file,
          String,
          desired_state: false

property :peer_client_cert_auth,
          [true, false],
          default: false,
          desired_state: false

property :peer_trusted_ca_file,
          String,
          desired_state: false

property :peer_auto_tls,
          [true, false],
          default: false,
          desired_state: false

property :etcdctl_client_cert_file,
          String,
          desired_state: false

property :etcdctl_client_key_file,
          String,
          desired_state: false

property :experimental_peer_skip_client_san_verification,
          [true, false],
          default: false,
          desired_state: false

property :peer_skip_client_san_verification,
          [true, false],
          default: false,
          desired_state: false

# Logging Flags
property :debug, [true, false],
          default: false,
          desired_state: false

property :log_package_levels,
          String,
          desired_state: false

property :log_format,
          String,
          default: 'json',
          desired_state: false

# Unsafe Flags
property :force_new_cluster,
          [true, false],
          default: false,
          desired_state: false

# Profiling Flags
property :enable_pprof,
          [true, false],
          default: false,
          desired_state: false

property :metrics,
          String,
          default: 'basic', desired_state: false

property :listen_metrics_urls,
          String,
          desired_state: false

# Auth Flags
property :auth_token,
          String,
          default: 'simple',
          desired_state: false

# Feature Gates (etcd 3.6+)
property :feature_gates,
          String,
          desired_state: false

# Misc
property :run_user,
          String,
          default: 'etcd',
          desired_state: false

property :http_proxy,
          String,
          desired_state: false

property :https_proxy,
          String,
          desired_state: false

property :no_proxy,
          String,
          desired_state: false

property :auto_restart,
          [true, false],
          default: false,
          desired_state: false

property :config_file,
          String,
          desired_state: false
