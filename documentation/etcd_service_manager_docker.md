# etcd_service_manager_docker

Run etcd in Docker with persistent storage isolated by instance name.

## Actions

| Action | Behaviour |
| --- | --- |
| `:start` (default) | Creates the instance data directory and runs the container |
| `:stop` | Stops the existing service without deleting data |
| `:restart` | Restarts the existing service |
| `:delete` | Stops and removes the container and its host data directory |

## Properties

Includes the [common properties](common.md).

| Property | Type | Default |
| --- | --- | --- |
| `repo` | `String` | `'quay.io/coreos/etcd'` |
| `tag` | `String` | `v<version>` |
| `container_name` | `String` | `etcd-<node_name>` |
| `port` | `Array` | `['2379/tcp4:2379', '2380/tcp4:2380']` |
| `network_mode` | `String` | `'host'` |
| `host_data_path` | `String` | `/var/lib/etcd/<node_name>` |

## Example

```ruby
etcd_service_manager_docker 'default' do
  action :start
end
```
