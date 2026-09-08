# etcd_installation_docker

Pull the upstream etcd container image. Requires a running Docker daemon.

## Actions

| Action | Behaviour |
| --- | --- |
| `:create` (default) | Pulls the selected image |
| `:delete` | Removes the selected image |

## Properties

Includes the [common properties](common.md).

| Property | Type | Default |
| --- | --- | --- |
| `repo` | `String` | `'quay.io/coreos/etcd'` |
| `tag` | `String` | `v<version>` |

## Example

```ruby
etcd_installation_docker 'default' do
  action :create
end
```
