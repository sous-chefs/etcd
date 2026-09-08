# etcd_installation_binary

Install verified etcd, etcdctl and etcdutl binaries. Also available as `etcd_installation`.

## Actions

| Action | Behaviour |
| --- | --- |
| `:create` (default) | Downloads and installs the selected release |
| `:delete` | Removes all three binaries and the selected cached archive |

## Properties

Includes the [common properties](common.md).

| Property | Type | Default |
| --- | --- | --- |
| `checksum` | `String` | `verified release checksum` |
| `source` | `String` | `official release archive URL` |
| `architecture` | `String` | `arm64 on aarch64; amd64 otherwise` |

## Example

```ruby
etcd_installation_binary 'default' do
  action :create
end
```

Binaries are shared in `/usr/bin`. Uninstall affects every instance using them. The system tar package is shared and is retained. Supply `source` and `checksum` for an unlisted release or architecture.
