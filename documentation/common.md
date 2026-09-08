# Common service properties

Shared by the installation, service and service manager resources. Most properties map directly to [etcd configuration options](https://etcd.io/docs/v3.7/op-guide/configuration/). Set optional properties only when needed. Flags removed in 3.6 or 3.7 are omitted for those versions.

| Property | Type | Default |
| --- | --- | --- |
| `default_service_name` | `[true, false]` | `false` |
| `version` | `String` | `'3.7.1'` |
| `node_name` | `String` | `resource name` |
| `data_dir` | `String` | `/<node_name>.etcd` |
| `wal_dir` | `String` | `unset` |
| `snapshot_count` | `String` | `unset` |
| `heartbeat_interval` | `String` | `unset` |
| `election_timeout` | `String` | `unset` |
| `listen_peer_urls` | `String` | `unset` |
| `listen_client_urls` | `String` | `unset` |
| `max_snapshots` | `String` | `unset` |
| `max_wals` | `String` | `unset` |
| `cors` | `String` | `unset` |
| `quota_backend_bytes` | `String` | `unset` |
| `max_request_bytes` | `Integer` | `unset` |
| `initial` | `String` | `unset` |
| `initial_advertise_peer_urls` | `String` | `unset` |
| `initial_cluster` | `String` | `unset` |
| `initial_cluster_state` | `String` | `unset` |
| `initial_cluster_token` | `String` | `unset` |
| `advertise_client_urls` | `String` | `unset` |
| `discovery` | `String` | `unset` |
| `discovery_srv` | `String` | `unset` |
| `discovery_fallback` | `String` | `unset` |
| `discovery_proxy` | `String` | `unset` |
| `discovery_token` | `String` | `unset` |
| `discovery_endpoints` | `String` | `unset` |
| `discovery_dial_timeout` | `Integer` | `unset` |
| `discovery_request_timeout` | `Integer` | `unset` |
| `discovery_keepalive_time` | `Integer` | `unset` |
| `discovery_keepalive_timeout` | `Integer` | `unset` |
| `discovery_insecure_transport` | `[true, false]` | `true` |
| `discovery_insecure_skip_tls_verify` | `[true, false]` | `false` |
| `discovery_cert` | `String` | `unset` |
| `discovery_key` | `String` | `unset` |
| `discovery_cacert` | `String` | `unset` |
| `discovery_user` | `String` | `unset` |
| `discovery_password` | `String` | `unset` |
| `strict_reconfig_check` | `[true, false]` | `false` |
| `auto_compaction_retention` | `String` | `'0'` |
| `enable_v2` | `[true, false]` | `true` |
| `proxy` | `String` | `unset` |
| `proxy_failure_wait` | `String` | `unset` |
| `proxy_refresh_interval` | `String` | `unset` |
| `proxy_dial_timeout` | `String` | `unset` |
| `proxy_write_timeout` | `String` | `unset` |
| `proxy_read_timeout` | `String` | `unset` |
| `cert_file` | `String` | `unset` |
| `key_file` | `String` | `unset` |
| `client_cert_auth` | `[true, false]` | `false` |
| `trusted_ca_file` | `String` | `unset` |
| `auto_tls` | `[true, false]` | `false` |
| `peer_cert_allowed_cn` | `String` | `unset` |
| `peer_cert_file` | `String` | `unset` |
| `peer_key_file` | `String` | `unset` |
| `peer_client_cert_auth` | `[true, false]` | `false` |
| `peer_trusted_ca_file` | `String` | `unset` |
| `peer_auto_tls` | `[true, false]` | `false` |
| `etcdctl_client_cert_file` | `String` | `unset` |
| `etcdctl_client_key_file` | `String` | `unset` |
| `experimental_peer_skip_client_san_verification` | `[true, false]` | `false` |
| `peer_skip_client_san_verification` | `[true, false]` | `false` |
| `debug` | `[true, false]` | `false` |
| `log_package_levels` | `String` | `unset` |
| `log_format` | `String` | `'json'` |
| `force_new_cluster` | `[true, false]` | `false` |
| `enable_pprof` | `[true, false]` | `false` |
| `metrics` | `String` | `'basic'` |
| `listen_metrics_urls` | `String` | `unset` |
| `auth_token` | `String` | `'simple'` |
| `feature_gates` | `String` | `unset` |
| `run_user` | `String` | `'etcd'` |
| `http_proxy` | `String` | `unset` |
| `https_proxy` | `String` | `unset` |
| `no_proxy` | `String` | `unset` |
| `auto_restart` | `[true, false]` | `false` |
| `config_file` | `String` | `unset` |
| `etcd_bin` | `String` | `'/usr/bin/etcd'` |

`discovery` is omitted for 3.7+. `discovery_srv` remains supported. `auto_restart` restarts systemd after managed unit or configuration changes. `config_file` selects YAML configuration instead of flags.

Discovery timeout and keepalive properties are integer nanoseconds. The CLI helper adds the `ns` unit; YAML configuration retains the integer value. Set `discovery_insecure_transport false` to require TLS for discovery connections.
