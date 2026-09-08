# etcd_service_manager_systemd

Configure and run an installed etcd binary with systemd. Also available as `etcd_service_manager`.

## Actions

| Action | Behaviour |
| --- | --- |
| `:start` (default) | Creates configuration and data directories, enables and starts the service |
| `:stop` | Stops the existing service without deleting data |
| `:restart` | Restarts the existing service |
| `:delete` | Stops, disables and removes the unit, configuration, data, WAL and legacy log/marker |

## Properties

Includes the [common properties](common.md).

| Property | Type | Default |
| --- | --- | --- |
| `service_timeout` | `Integer` | `120` |

## Example

```ruby
etcd_service_manager_systemd 'default' do
  action :start
end
```
