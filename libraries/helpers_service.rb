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
        opts << "-name=#{node_name}" unless node_name.nil?
        opts << "-advertise-client-urls=#{advertise_client_urls}" unless advertise_client_urls.nil?
        opts << "-cert-file=#{cert_file}" unless cert_file.nil?
        opts << '-client-cert-auth=true' if client_cert_auth == true
        opts << "-cors=#{cors}" unless cors.nil?
        opts << "-data-dir=#{data_dir}" unless data_dir.nil?
        opts << '-debug=true' if debug == true
        opts << "-discovery-fallback=#{discovery_fallback}" unless discovery_fallback.nil?
        opts << "-discovery-proxy=#{discovery_proxy}" unless discovery_proxy.nil?
        opts << "-discovery-srv=#{discovery_srv}" unless discovery_srv.nil?
        opts << "-discovery=#{discovery}" unless discovery.nil?
        opts << "-election-timeout=#{election_timeout}" unless election_timeout.nil?
        opts << '-experimental-v3demo=true' if experimental_v3demo == true
        opts << "-force-new-cluster=#{force_new_cluster}" unless force_new_cluster.nil?
        opts << "-heartbeat-interval=#{heartbeat_interval}" unless heartbeat_interval.nil?
        opts << "-initial-advertise-peer-urls=#{initial_advertise_peer_urls}" unless initial_advertise_peer_urls.nil?
        opts << "-initial-cluster-state=#{initial_cluster_state}" unless initial_cluster_state.nil?
        opts << "-initial-cluster-token=#{initial_cluster_token}" unless initial_cluster_token.nil?
        opts << "-initial-cluster=#{initial_cluster}" unless initial_cluster.nil?
        opts << "-initial=#{initial}" unless initial.nil?
        opts << "-key-file=#{key_file}" unless key_file.nil?
        opts << "-listen-client-urls=#{listen_client_urls}" unless listen_client_urls.nil?
        opts << "-listen-peer-urls=#{listen_peer_urls}" unless listen_peer_urls.nil?
        opts << "-max-snapshots=#{max_snapshots}" unless max_snapshots.nil?
        opts << "-max-wals=#{max_wals}" unless max_wals.nil?
        opts << "-peer-cert-file=#{peer_cert_file}" unless peer_cert_file.nil?
        opts << '-peer-client-cert-auth=true' if peer_client_cert_auth == true
        opts << "-peer-key-file=#{peer_key_file}" unless peer_key_file.nil?
        opts << "-peer-trusted-ca-file=#{peer_trusted_ca_file}" unless peer_trusted_ca_file.nil?
        opts << "-proxy-dial-timeout=#{proxy_dial_timeout}" unless proxy_dial_timeout.nil?
        opts << "-proxy-failure-wait=#{proxy_failure_wait}" unless proxy_failure_wait.nil?
        opts << "-proxy-read-timeout=#{proxy_read_timeout}" unless proxy_read_timeout.nil?
        opts << "-proxy-refresh-interval=#{proxy_refresh_interval}" unless proxy_refresh_interval.nil?
        opts << "-proxy-write-timeout=#{proxy_write_timeout}" unless proxy_write_timeout.nil?
        opts << "-proxy=#{proxy}" unless proxy.nil?
        opts << "-snapshot-count=#{snapshot_count}" unless snapshot_count.nil?
        opts << "-trusted-ca-file=#{trusted_ca_file}" unless trusted_ca_file.nil?
        opts << "-wal-dir=#{wal_dir}" unless wal_dir.nil?
        opts
      end

      def etcd_name
        "etcd-#{node_name}"
      end

      def etcdctl_bin
        '/usr/bin/etcdctl'
      end

      def etcdctl_cmd
        [etcdctl_bin, etcdctl_opts].join(' ').strip
      end

      def etcdctl_opts
        opts = []
        opts << "-C #{advertise_client_urls}" if advertise_client_urls
      end

      def logfile
        "/var/log/#{etcd_name}.log"
      end
    end
  end
end
