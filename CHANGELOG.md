# etcd Cookbook CHANGELOG
This file is used to list changes made in each version of the etcd cookbook.

## 3.2.5
- Added Redhat, Oracle Linux, and Scientific Linux to the metadata
- Fixed issues_url and source_url in the metadata to point to the correct URL
- Added license to the metadata
- Updated Rakefile so testing tasks match other Chef cookbooks
- Add maintainers files and Rake task to generate the markdown

## 3.2.4
- Added support for Scientific / Oracle Linux 6.X
- Fixed readme badges
- Added a chefignore file
- Add contributing and testing docs
- Removed Ruby 2.2 via RVM install from the Travis CI runs

## 3.2.3
- Retrying key operations

## 3.2.2
- Using converge_if_changed in :set action

## 3.2.1
- Adding etcd_key resource
- Removing unused property previous_state
- Adding desired_state: false to various properties

## 3.2.0
- Adding etcd_key resource

## 3.1.6
- Fix redirecting stderr to stdout in upstart manaager

## 3.1.5
- Fix timeout pattern in systemd-wait-ready

## 3.1.4
- Fixing up docker service manager tests

## 3.1.3
- Fixing incorrectly named classes in service managers

## 3.1.2
- Fixing wait-ready script to use etcdctl_cmd

## 3.1.1
- Adding docker to etcd_service

## 3.1.0
- Supporting run_user on service manager resources

## 3.0.0
- New major version, non-backwards compatible with 2.x.x
- Rewritten as Custom Resources
- Defaulting to etcd version 2.2.2

## 2.2.2
- update to etcd 0.4.6
- adds debian support

## 2.2.1
- update to etcd 0.4.5
- Add centos 7 support
- Support centos cloud images without tar
- Dry out compile time recipe
- Move to berks3

## 2.2.0
- update to etcd 0.4.2
- Removed node[:etcd][:local] No longer needed in new etcd. Etcd will default bind :4001 and :7001.
- The cookbook default is now to use node[:ipaddress] as the  addr and peer_addr.
- add auto-respawn instruction in upstart config file
- Fix Gem deps in the ci build

## 2.1.3
- add peer and peer_addr support / attributes
- add name attribute and computation
- fixup cmdline argument computation
- ensure cluster members are always sorted
- fix spec tests

## 2.1.2
- fix bug in cluster recipe where Resolv was spelled wrong
- fix kitchen test on cluster to pickup this issue.
- add basic chefspec as well to ensure this sort of issue doesn't occur
- fix bug with name attribute methods
- fix searching for wrong recipe when using cluster recipe

## 2.1.1
- update to etcd 0.3.0
- Add support for new discovery mode
- refactor common functions into library methods
- Add specs
- Use rubocop to replace tailor/cane
- Fixup testing (add travis integration)

## 2.0.0
- update to etcd 0.2.0
- remove `name_switch` attribute. It was marked for deprication in 1.3
- enable snapshotting by default
- add optional local listener
- support chef-solo
- Add support of explicitely specifying a cluster's nodes

## 1.3.5
- silence foodcritic by accessing attributes in a consistent manner,
- trigger a restart when etcd conf is updated
- include git if source install
- metadata depends on git recipe
- Update Documentation
- Update contributors

## 1.3.4
- fix compile_time to use the right tarball path

## 1.3.3
- Bump to etcd 1.2
- Added source install recipe

## 1.3.1
- default binding to node[:ipaddress]

## 1.2.4
- update to etcd 0.1.1 release
- add compile_time recipe that does the whole bit in chef compile time

## 1.2.3
- hotfix to add missing  `node[:etcd][:env_scope]` attribute
- bugfix: use `node[:fqdn]` instead of hostname when matching local machine name

## 1.2.2
- add cluster recipe for setting up clusters of etcd nodes
- re-add seed-node attribute

## 1.2.1
- fix the startup args so it is easier to specify custom args
- supports release version and current master on git
- add in tests for both release and git versions of etcd

## 1.1.1
- Make everything work with release 0.1.0 of etcd
- fixup some syntax issues

## 1.1.0
- move binary install to using coreos/etcd releases from github
- for now the install locattion is fixed to /usr/local and links in /usr/local/bin
- Use ark for managing tarballs
- move bats tests to using etcdctl instead of curl
