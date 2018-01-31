module EtcdCookbook
  module EtcdHelpers
    module Service
      def etcd_bin
        '/usr/bin/etcd'
      end

      def etcd_cmd
        [etcd_bin, etcd_daemon_opts].join(' ').strip
      end

      def etcd_daemon_opts
        opts = []
        opts << "-name=#{new_resource.node_name}" unless new_resource.node_name.nil?
        opts << "-advertise-client-urls=#{new_resource.advertise_client_urls}" unless new_resource.advertise_client_urls.nil?
        opts << "-cert-file=#{new_resource.cert_file}" unless new_resource.cert_file.nil?
        opts << '-client-cert-auth=true' if new_resource.client_cert_auth == true
        opts << "-cors=#{new_resource.cors}" unless new_resource.cors.nil?
        opts << "-data-dir=#{new_resource.data_dir}" unless new_resource.data_dir.nil?
        opts << "-debug=#{new_resource.debug}"
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
        opts << "-peer-cert-file=#{new_resource.peer_cert_file}" unless new_resource.peer_cert_file.nil?
        opts << '-peer-client-cert-auth=true' if new_resource.peer_client_cert_auth == true
        opts << "-peer-key-file=#{new_resource.peer_key_file}" unless new_resource.peer_key_file.nil?
        opts << "-peer-trusted-ca-file=#{new_resource.peer_trusted_ca_file}" unless new_resource.peer_trusted_ca_file.nil?
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
        opts << "-auth-token=#{new_resource.auth_token}"
        opts
      end

      def etcd_name
        "etcd-#{new_resource.node_name}"
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
