# etcd_key

Manage v3 keys using an installed etcdctl client. Values are sent through standard input and resource output is sensitive by default.

## Actions

| Action | Behaviour |
| --- | --- |
| `:set` (default) | Sets the value and optional lease only when they differ |
| `:delete` | Deletes the key if present |
| `:watch` | Streams key changes until command completion or watch_timeout; this blocks the Chef run |

## Properties

| Property | Type | Default |
| --- | --- | --- |
| `sensitive` | `[true, false]` | `true` |
| `key` | `String` | `resource name` |
| `value` | `String` | `unset` |
| `ttl` | `[Integer, String]` | `0` |
| `host` | `String` | `'127.0.0.1'` |
| `port` | `Integer` | `2379` |
| `scheme` | `%w(http https)` | `'http'` |
| `cacert` | `String` | `unset` |
| `cert` | `String` | `unset` |
| `client_key` | `String` | `unset` |
| `etcdctl_bin` | `String` | `'/usr/bin/etcdctl'` |
| `command_timeout` | `Integer` | `30` |
| `watch_timeout` | `Integer` | `600` |

## Example

```ruby
etcd_key 'default' do
  value 'example value'
  action :set
end
```

`ttl` is the lease duration in seconds; `0` means persistent. An unchanged leased value keeps its existing lease. Reads and writes fail on connection or TLS errors. Set `scheme`, `cacert`, `cert` and `client_key` for TLS. This resource does not migrate v2 keys.
