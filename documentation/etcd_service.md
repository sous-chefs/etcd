# etcd_service

Install etcd and manage an instance through systemd or Docker.

## Actions

| Action | Behaviour |
| --- | --- |
| `:create` (default) | Installs etcd; use `[:create, :start]` to run it |
| `:delete` | Deletes the service and its data, then uninstalls the selected binary or image |
| `:start` | Configures and starts the service |
| `:stop` | Stops the existing service without deleting data |
| `:restart` | Restarts the existing service |

## Properties

Includes the [common properties](common.md).

| Property | Type | Default |
| --- | --- | --- |
| `install_method` | `%w(binary auto docker none)` | `'auto'` |
| `service_manager` | `%w(systemd auto docker)` | `'auto'` |
| `checksum` | `String` | `unset` |
| `source` | `String` | `unset` |

## Example

```ruby
etcd_service 'default' do
  action [:create, :start]
end
```
