# Migrating to the resource-only etcd cookbook

This major release keeps the existing six resource names and the `etcd_installation` and `etcd_service_manager` aliases. Root recipes and attributes were already absent; no recipe or node-attribute API is being removed.

## Required changes

* `etcd_key` now manages v3 keys through `etcdctl`. The old vendored Ruby client used v2, which etcd 3.7 no longer supports. Install etcdctl before using this resource. Migrate v2 data separately before upgrading; v2 and v3 keyspaces are distinct.
* The default version is 3.7.1. Follow [upstream upgrade instructions](https://etcd.io/docs/v3.7/upgrades/upgrade_3_7/) for existing clusters. This cookbook does not orchestrate rolling cluster upgrades.
* Docker instances now default to `/var/lib/etcd/<node_name>`. Set `host_data_path '/var/lib/etcd'` explicitly when reusing a previous single-instance data location. Give clustered instances distinct data paths.
* `:stop` really stops the service and preserves data. `:restart` restarts the existing service. `:delete` now removes instance data and configuration as well as the service; only use it for deliberate teardown. Binary uninstall affects all instances sharing `/usr/bin`.
* Use current Linux releases listed in `metadata.rb` and Kitchen. Amazon Linux 2, openSUSE Leap 15 and Ubuntu 20.04 are no longer in the standard-support test matrix.

## Usage

```ruby
etcd_service 'default' do
  version '3.7.1'
  action [:create, :start]
end

etcd_key '/example' do
  value 'hello'
end
```

See the [test cookbook recipes](test/cookbooks/test/recipes) for systemd, Docker, clustering and YAML configuration examples. Dependencies now use `chef install Policyfile.rb`; Berkshelf is no longer used. Both local tests and CI use privileged Dokken containers.
