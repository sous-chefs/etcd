module EtcdCookbook
  module EtcdHelpers
    module Service
      def etcd_bin
        '/usr/bin/etcd'
      end

      def etcd_cmd
        if new_resource.config_file.nil?
          [etcd_bin, etcd_daemon_opts].join(' ').strip
        else
          create_config_file
          [etcd_bin, '--config-file', new_resource.config_file].join(' ').strip
        end
      end

      def create_config_file
        directory ::File.dirname(new_resource.config_file) do
          owner new_resource.run_user
          group 'root'
          mode '0755'
          action :create
        end

        template new_resource.config_file do
          source 'config/etcd.conf.yml.erb'
          owner new_resource.run_user
          cookbook 'etcd'
          group 'root'
          mode '0750'
          variables instance_name: new_resource.node_name,
                    data_dir: new_resource.data_dir,
                    wal_dir: new_resource.wal_dir,
                    snapshot_count: new_resource.snapshot_count,
                    heartbeat_interval: new_resource.heartbeat_interval,
                    election_timeout: new_resource.election_timeout,
                    listen_peer_urls: new_resource.listen_peer_urls,
                    listen_client_urls: new_resource.listen_client_urls,
                    max_snapshots: new_resource.max_snapshots,
                    max_wals: new_resource.max_wals,
                    cors: new_resource.cors,
                    quota_backend_bytes: new_resource.quota_backend_bytes,
                    initial_advertise_peer_urls: new_resource.initial_advertise_peer_urls,
                    initial_cluster: new_resource.initial_cluster,
                    initial_cluster_state: new_resource.initial_cluster_state,
                    initial_cluster_token: new_resource.initial_cluster_token,
                    advertise_client_urls: new_resource.advertise_client_urls,
                    discovery: new_resource.discovery,
                    discovery_fallback: new_resource.discovery_fallback,
                    discovery_proxy: new_resource.discovery_proxy,
                    discovery_srv: new_resource.discovery_srv,
                    strict_reconfig_check: new_resource.strict_reconfig_check,
                    auto_compaction_retention: new_resource.auto_compaction_retention,
                    enable_v2: new_resource.enable_v2,
                    cert_file: new_resource.cert_file,
                    key_file: new_resource.key_file,
                    client_cert_auth: new_resource.client_cert_auth,
                    trusted_ca_file: new_resource.trusted_ca_file,
                    auto_tls: new_resource.auto_tls,
                    peer_cert_file: new_resource.peer_cert_file,
                    peer_key_file: new_resource.peer_key_file,
                    peer_client_cert_auth: new_resource.peer_client_cert_auth,
                    peer_trusted_ca_file: new_resource.peer_trusted_ca_file,
                    peer_auto_tls: new_resource.peer_auto_tls,
                    peer_cert_allowed_cn: new_resource.peer_cert_allowed_cn,
                    auth_token: new_resource.auth_token,
                    debug: new_resource.debug,
                    force_new_cluster: new_resource.force_new_cluster,
                    enable_pprof: new_resource.enable_pprof,
                    proxy: new_resource.proxy,
                    proxy_failure_wait: new_resource.proxy_failure_wait,
                    proxy_refresh_interval: new_resource.proxy_refresh_interval,
                    proxy_dial_timeout: new_resource.proxy_dial_timeout,
                    proxy_write_timeout: new_resource.proxy_write_timeout,
                    proxy_read_timeout: new_resource.proxy_read_timeout,
                    metrics: new_resource.metrics,
                    listen_metrics_urls: new_resource.listen_metrics_urls,
                    experimental_peer_skip_client_san_verification: new_resource.experimental_peer_skip_client_san_verification
        end
      end

      def etcd_daemon_opts
        opts = []
        opts << "-name=#{new_resource.node_name}" unless new_resource.node_name.nil?
        opts << "-advertise-client-urls=#{new_resource.advertise_client_urls}" unless new_resource.advertise_client_urls.nil?
        opts << "-cert-file=#{new_resource.cert_file}" unless new_resource.cert_file.nil?
        opts << '-client-cert-auth=true' if new_resource.client_cert_auth == true
        opts << "-cors=#{new_resource.cors}" unless new_resource.cors.nil?
        opts << "-data-dir=#{new_resource.data_dir}" unless new_resource.data_dir.nil?
        opts << "-log_package_levels=#{new_resource.log_package_levels}" unless new_resource.log_package_levels.nil?
        opts << "-discovery-fallback=#{new_resource.discovery_fallback}" unless new_resource.discovery_fallback.nil?
        opts << "-discovery-proxy=#{new_resource.discovery_proxy}" unless new_resource.discovery_proxy.nil?
        opts << '-strict-reconfig-check=true' if new_resource.strict_reconfig_check == true
        opts << "-auto-compaction-retention=#{new_resource.auto_compaction_retention}"
        opts << "-enable-v2=#{new_resource.enable_v2}"
        opts << "-discovery-srv=#{new_resource.discovery_srv}" unless new_resource.discovery_srv.nil?
        opts << "-discovery=#{new_resource.discovery}" unless new_resource.discovery.nil?
        opts << "-election-timeout=#{new_resource.election_timeout}" unless new_resource.election_timeout.nil?
        opts << "-force-new-cluster=#{new_resource.force_new_cluster}" unless new_resource.force_new_cluster.nil?
        opts << "-heartbeat-interval=#{new_resource.heartbeat_interval}" unless new_resource.heartbeat_interval.nil?
        opts << "-initial-advertise-peer-urls=#{new_resource.initial_advertise_peer_urls}" unless new_resource.initial_advertise_peer_urls.nil?
        opts << "-initial-cluster-state=#{new_resource.initial_cluster_state}" unless new_resource.initial_cluster_state.nil?
        opts << "-initial-cluster-token=#{new_resource.initial_cluster_token}" unless new_resource.initial_cluster_token.nil?
        opts << "-initial-cluster=#{new_resource.initial_cluster}" unless new_resource.initial_cluster.nil?
        opts << "-initial=#{new_resource.initial}" unless new_resource.initial.nil?
        opts << "-key-file=#{new_resource.key_file}" unless new_resource.key_file.nil?
        opts << "-listen-client-urls=#{new_resource.listen_client_urls}" unless new_resource.listen_client_urls.nil?
        opts << "-listen-peer-urls=#{new_resource.listen_peer_urls}" unless new_resource.listen_peer_urls.nil?
        opts << "-max-snapshots=#{new_resource.max_snapshots}" unless new_resource.max_snapshots.nil?
        opts << "-max-wals=#{new_resource.max_wals}" unless new_resource.max_wals.nil?
        opts << "-peer-cert-allowed-cn=#{new_resource.peer_cert_allowed_cn}" unless new_resource.peer_cert_allowed_cn.nil?
        opts << "-peer-cert-file=#{new_resource.peer_cert_file}" unless new_resource.peer_cert_file.nil?
        opts << '-peer-client-cert-auth=true' if new_resource.peer_client_cert_auth == true
        opts << "-peer-key-file=#{new_resource.peer_key_file}" unless new_resource.peer_key_file.nil?
        opts << "-peer-trusted-ca-file=#{new_resource.peer_trusted_ca_file}" unless new_resource.peer_trusted_ca_file.nil?
        opts << '-experimental-peer-skip-client-san-verification=true' if new_resource.experimental_peer_skip_client_san_verification == true
        opts << "-auto-tls=#{new_resource.auto_tls}"
        opts << "-peer-auto-tls=#{new_resource.peer_auto_tls}"
        opts << "-proxy-dial-timeout=#{new_resource.proxy_dial_timeout}" unless new_resource.proxy_dial_timeout.nil?
        opts << "-proxy-failure-wait=#{new_resource.proxy_failure_wait}" unless new_resource.proxy_failure_wait.nil?
        opts << "-proxy-read-timeout=#{new_resource.proxy_read_timeout}" unless new_resource.proxy_read_timeout.nil?
        opts << "-proxy-refresh-interval=#{new_resource.proxy_refresh_interval}" unless new_resource.proxy_refresh_interval.nil?
        opts << "-proxy-write-timeout=#{new_resource.proxy_write_timeout}" unless new_resource.proxy_write_timeout.nil?
        opts << "-proxy=#{new_resource.proxy}" unless new_resource.proxy.nil?
        opts << "--quota-backend-bytes=#{new_resource.quota_backend_bytes}" unless new_resource.quota_backend_bytes.nil?
        opts << "-snapshot-count=#{new_resource.snapshot_count}" unless new_resource.snapshot_count.nil?
        opts << "-trusted-ca-file=#{new_resource.trusted_ca_file}" unless new_resource.trusted_ca_file.nil?
        opts << "-wal-dir=#{new_resource.wal_dir}" unless new_resource.wal_dir.nil?
        opts << "-enable-pprof=#{new_resource.enable_pprof}"
        opts << "-metrics=#{new_resource.metrics}"
        opts << "-listen-metrics-urls=#{new_resource.listen_metrics_urls}" unless new_resource.listen_metrics_urls.nil?
        opts << "-auth-token=#{new_resource.auth_token}"
        opts
      end

      def etcd_name
        if new_resource.default_service_name
          'etcd'
        else
          "etcd-#{new_resource.node_name}"
        end
      end

      def etcdctl_bin
        '/usr/bin/etcdctl'
      end

      def etcdctl_cmd
        [etcdctl_bin, etcdctl_opts].join(' ').strip
      end

      def etcdctl_opts
        opts = []
        # The client cert must be the same file as the server cert
        if new_resource.client_cert_auth == true
          opts << "--ca-file=#{new_resource.trusted_ca_file}"
          opts << "--cert-file=#{new_resource.cert_file}"
          opts << "--key-file=#{new_resource.key_file}"
        end
        opts << "-C #{new_resource.advertise_client_urls}" if new_resource.advertise_client_urls
      end

      def logfile
        "/var/log/#{etcd_name}.log"
      end
    end
  end
end
