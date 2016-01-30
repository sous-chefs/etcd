Etcd Cookbook
=============
[![Build Status](https://travis-ci.org/chef-cookbooks/etcd.svg?branch=master)](https://travis-ci.org/chef-cookbooks/etcd)
[![Cookbook Version](https://img.shields.io/cookbook/v/etcd.svg)](https://supermarket.chef.io/cookbooks/etcd)

The Etcd Cookbook is a library cookbook that provides custom resources
for use in recipes.

Scope
-----
This cookbook is concerned with the [Etcd](https://coreos.com/etcd/)
distributed key/value store as distributed by CoreOS, Inc.

Requirements
------------
- Chef 12.0.0 or higher. Chef 11 is NOT SUPPORTED, please do not open issues about it.
- Ruby 2.1 or higher (preferably, the Chef full-stack installer)
- Network accessible web server hosting the etcd binary.

Platform Support
----------------
The following platforms have been tested with Test Kitchen. It will
most likely work on other platforms as well

```
|--------------+-------+
|              | 2.2.2 |
|--------------+-------+
| debian-8     | X     |
|--------------+-------+
| centos-5     | X     |
|--------------+-------+
| centos-6     | X     |
|--------------+-------+
| centos-7     | X     |
|--------------+-------+
| fedora-21    | X     |
|--------------+-------+
| ubuntu-12.04 | X     |
|--------------+-------+
| ubuntu-14.04 | X     |
|--------------+-------+
| ubuntu-15.10 | X     |
|--------------+-------+
```

Cookbook Dependencies
---------------------
- [compat_resource](https://supermarket.chef.io/cookbooks/compat_resource)

Usage
-----
- Add ```depends 'etcd', '~> 3.0'``` to your cookbook's metadata.rb
- Use the resources shipped in cookbook in a recipe, the same way you'd
  use core Chef resources (file, template, directory, package, etc).

```ruby
etcd_service 'etcd0' do
  advertise_client_urls 'http://127.0.0.1:2379,http://127.0.0.1:4001'
  listen_client_urls 'http://0.0.0.0:2379,http://0.0.0.0:4001'
  initial_advertise_peer_urls 'http://127.0.0.1:2380'
  listen_peer_urls 'http://0.0.0.0:2380'
  initial_cluster_token 'etcd-cluster-1'
  initial_cluster 'etcd0=http://127.0.0.1:2380,etcd1=http://127.0.0.1:3380,etcd2=http://127.0.0.1:4380'
  initial_cluster_state 'new'
  action :start
end

etcd_service 'etcd1' do
  advertise_client_urls 'http://127.0.0.1:3379,http://127.0.0.1:5001'
  listen_client_urls 'http://0.0.0.0:3379,http://0.0.0.0:5001'
  initial_advertise_peer_urls 'http://127.0.0.1:3380'
  listen_peer_urls 'http://0.0.0.0:3380'
  initial_cluster_token 'etcd-cluster-1'
  initial_cluster 'etcd0=http://127.0.0.1:2380,etcd1=http://127.0.0.1:3380,etcd2=http://127.0.0.1:4380'
  initial_cluster_state 'new'
  action :start
end

etcd_service 'etcd2' do
  advertise_client_urls 'http://127.0.0.1:4379,http://127.0.0.1:6001'
  listen_client_urls 'http://0.0.0.0:4379,http://0.0.0.0:6001'
  initial_advertise_peer_urls 'http://127.0.0.1:4380'
  listen_peer_urls 'http://0.0.0.0:4380'
  initial_cluster_token 'etcd-cluster-1'
  initial_cluster 'etcd0=http://127.0.0.1:2380,etcd1=http://127.0.0.1:3380,etcd2=http://127.0.0.1:4380'
  initial_cluster_state 'new'
  action :start
end
```

Test Cookbooks as Examples
--------------------------
The cookbooks ran under test-kitchen make excellent usage examples.

The test recipes are found at:
```ruby
test/cookbooks/etcd_test/
```

Resources Overview
------------------
* `etcd_service`: composite resource that uses etcd_installation and etcd_service_manager
* `etcd_installation`: automatically selects an installation method
* `etcd_service_manager`: automatically selects a service manager
* `etcd_key`: manages keys in etcd

* `etcd_installation_binary`: copies a pre-compiled etcd binary onto disk
* `etcd_installation_docker`: pulls a docker image to the DOCKER_HOST
* `etcd_service_manager_execute`: manage etcd daemon with Chef
* `etcd_service_manager_sysvinit`: manage etcd daemon with a sysvinit script
* `etcd_service_manager_upstart`: manage etcd daemon with upstart script
* `etcd_service_manager_systemd`: manage etcd daemon with systemd unit files
* `etcd_service_manager_docker`: starts a docker process on the DOCKER_HOST


Resources Details
------------------
## etcd_installation
The `etcd_installation` resource auto-selects one of the below
resources with the provider resolution system. Currently only the
binary installation is available. Packages will be supported in the
future versions.

#### Example
```ruby
etcd_installation 'default' do
  action :create
end
```

## etcd_installation_binary
The `etcd_installation_binary` resource copies the precompiled Go binary onto
the disk. It exists to help run older Etcd versions. It should not
be used in production, especially with devicemapper.

#### Example
```ruby
etcd_installation_binary 'default' do
  version '2.2.2'
  source 'https://my.computers.biz/dist/etcd'
  checksum '90aff7364caa43932fd46974825af20e0ecb70fe7e01981e2d3a496106f147e7'
  action :create
end
```

## etcd_installation_docker
The `etcd_installation_docker` resource uses the `docker_image` resource
to pull an image to the DOCKER_HOST.

#### Properties
- `repo` - The image name to pull. Defaults to 'quay.io/coreos/etcd'
- `tag` - The image tag to pull.
- `version` - String used to calculate tag string when tag is ommited.
  Defaults to '2.2.2'

## etcd_service_manager
The `etcd_service_manager` resource auto-selects one of the below
resources with the provider resolution system. The
`etcd_service` family all share a common set of properties, which
are listed under the `etcd_service` composite resource.

#### Example
```ruby
etcd_service_manager 'default' do
  action :start
end
```

## etcd_service_manager_execute
#### Example
```ruby
etcd_service_manager_execute 'default' do
  action :start
end
```

## etcd_service_manager_sysvinit
#### Example
```ruby
etcd_service_manager_sysvinit 'default' do
  action :stop
end
```

## etcd_service_manager_upstart
#### Example
```ruby
etcd_service_manager_upstart 'default' do
  action :start
end
```

## etcd_service_manager_systemd
#### Example
```ruby
etcd_service_manager_systemd 'default' do
  action :start
end
```

## etcd_service_manager_docker
#### Example
```ruby
etcd_service_manager_docker 'default' do
  action :start
end
```
# properties
- repo - defaults to 'quay.io/coreos/etcd'
- tag - default calculated from version
- version - defaults to '2.2.2',
- container_name - defaults to resource name
- port - defaults to  ['2379/tcp4:2379', '4001/tcp4:4001']

## etcd_service
The `etcd_service`: resource is a composite resource that uses
`etcd_installation` and `etcd_service_manager` resources.

- The `:create` action uses an `etcd_installation`
- The `:delete` action uses an`etcd_installation`
- The `:start` action uses an `etcd_service_manager`
- The `:stop` action uses an `etcd_service_manager`

The service management strategy for the host platform is dynamically
chosen based on platform, but can be overridden.

# Properties
The `etcd_service` resource property list corresponds to the options
found in

[Etcd Configuration Flags documentation](https://coreos.com/etcd/docs/2.2.2/configuration.html)

- Member flags
- `source`
- `node_name`
- `data_dir`
- `wal_dir`
- `snapshot_count`
  snapshot to disk.
- `heartbeat_interval`
- `election_timeout`
- `listen_peer_urls`
- `listen_client_urls`
- `max_snapshots`
- `max_wals`
- `cors`

- Clustering Flags
- `initial`
- `initial_advertise_peer_urls`
- `initial_cluster`
- `initial_cluster_state`
- `initial_cluster_token`
- `advertise_client_urls`
- `discovery`
- `discovery_srv`
- `discovery_fallback`
- `discovery_proxy`

- Proxy Flags
- `proxy` -
- `proxy_failure_wait`
- `proxy_refresh_interval`
- `proxy_dial_timeout`
- `proxy_write_timeout`
- `proxy_read_timeout`

- Security Flags
- `cert_file`
- `key_file`
- `client_cert_auth`
- `trusted_ca_file`
- `peer_cert_file`
- `peer_key_file`
- `peer_client_cert_auth`
- `peer_trusted_ca_file`

- Logging Flags
- `debug`

- Unsafe Flags
- `force_new_cluster`

- Experimental Flags
- `experimental_v3demo`

- Misc
- `http_proxy`
- `https_proxy`
- `no_proxy`
- `auto_restart`

## etcd_key
The `etcd_key` resource sets, watches and deletes keys in etcd.

### Actions

 - The `:set` action sets a key
 - The `:delete` action deletes a key
 - The `:watch` action waits for a key to update

### Properties
- `key` - The key name
- `value` - The desired value
- `ttl` - The ttl for the key (optional)
- `host` - The hostname of the etcd server, defaults to `127.0.0.1`
- `port` - The port that etcd is listening on, defaults to `2379`

### Examples

```
etcd_key "/test" do
  value "a_test_value"
  action :set
end
```

License and Author
------------------
|                      |                                                |
|----------------------|------------------------------------------------|
| **Original Author**  | [Jesse Nelson]( https://github.com/spheromak)  |
| **Contributor**      | [Soulou](https://github.com/Soulou)            |
| **Contributor**      | [Aaron O'Mullan](https://github.com/AaronO)    |
| **Contributor**      | [Anthony Scalisi](https://github.com/scalp42)  |
| **Contributor**      | [Robert Coleman](https://github.com/rjocoleman)|
| **Contributor**      | [James Gregory](https://github.com/jagregory)  |
| **Contributor**      | [Sean OMeara](https://github.com/someara)      |
| **Copyright**        | Copyright (c) 2013, Jesse Nelson               |

## License
Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
