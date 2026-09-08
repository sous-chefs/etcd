# Etcd Cookbook

[![Cookbook Version](https://img.shields.io/cookbook/v/etcd.svg)](https://supermarket.chef.io/cookbooks/etcd)
[![CI State](https://github.com/sous-chefs/etcd/workflows/ci/badge.svg)](https://github.com/sous-chefs/etcd/actions?query=workflow%3Aci)

Manage [etcd](https://etcd.io) with Chef custom resources. The default etcd release is 3.7.1.

## Requirements

* Chef Infra Client 16 or later, or a compatible Cinc Client.
* Linux with systemd, or a running Docker daemon for container resources.
* Network access to the upstream archive or container registry.

Binary installation supports Linux amd64 and arm64 with verified default-release checksums. The Kitchen matrix covers current AlmaLinux, Amazon Linux, CentOS Stream, Debian, Fedora, openSUSE Leap, Oracle Linux, Rocky Linux and Ubuntu releases. RHEL and SLES support is retained; those require their own licensed test environments. See `metadata.rb` for version bounds and [testing](TESTING.md) for verification commands.

## Upgrade

Read the [migration guide](migration.md) before upgrading an existing deployment. Key resources now use the v3 API, Docker data paths are isolated per instance, and deletion removes instance data.

## Usage

```ruby
etcd_service 'default' do
  action [:create, :start]
end

etcd_key '/example' do
  value 'hello'
end
```

The cookbook provides resources rather than recipes or node attributes. See [test recipes](test/cookbooks/test/recipes) for complete examples.

## Resources

* [etcd_installation_binary](documentation/etcd_installation_binary.md)
* [etcd_installation_docker](documentation/etcd_installation_docker.md)
* [etcd_service](documentation/etcd_service.md)
* [etcd_service_manager_systemd](documentation/etcd_service_manager_systemd.md)
* [etcd_service_manager_docker](documentation/etcd_service_manager_docker.md)
* [etcd_key](documentation/etcd_key.md)

`etcd_installation` aliases the binary installer; `etcd_service_manager` aliases the systemd manager. The [common properties](documentation/common.md) describe service and cluster configuration.

## Maintainers

Maintained by [Sous Chefs](https://sous-chefs.org/). Docker resources depend on the [docker cookbook](https://github.com/sous-chefs/docker).

## Contributors

This project exists thanks to all the people who [contribute.](https://opencollective.com/sous-chefs/contributors.svg?width=890&button=false)

### Additional Contributors

* [Jesse Nelson](https://github.com/spheromak)
* [Soulou](https://github.com/Soulou)
* [Aaron O'Mullan](https://github.com/AaronO)
* [Anthony Scalisi](https://github.com/scalp42)
* [Robert Coleman](https://github.com/rjocoleman)
* [James Gregory](https://github.com/jagregory)
* [Sean OMeara](https://github.com/someara)

### Backers

Thank you to all our backers!

![https://opencollective.com/sous-chefs#backers](https://opencollective.com/sous-chefs/backers.svg?width=600&avatarHeight=40)

### Sponsors

Support this project by becoming a sponsor. Your logo will show up here with a link to your website.

![https://opencollective.com/sous-chefs/sponsor/0/website](https://opencollective.com/sous-chefs/sponsor/0/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/1/website](https://opencollective.com/sous-chefs/sponsor/1/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/2/website](https://opencollective.com/sous-chefs/sponsor/2/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/3/website](https://opencollective.com/sous-chefs/sponsor/3/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/4/website](https://opencollective.com/sous-chefs/sponsor/4/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/5/website](https://opencollective.com/sous-chefs/sponsor/5/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/6/website](https://opencollective.com/sous-chefs/sponsor/6/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/7/website](https://opencollective.com/sous-chefs/sponsor/7/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/8/website](https://opencollective.com/sous-chefs/sponsor/8/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/9/website](https://opencollective.com/sous-chefs/sponsor/9/avatar.svg?avatarHeight=100)
