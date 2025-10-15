# etcd Cookbook CHANGELOG

This file is used to list changes made in each version of the etcd cookbook.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

Standardise files with files in sous-chefs/repo-management
Standardise files with files in sous-chefs/repo-management

## 11.0.0 - *2025-07-10*

Add `etcdutl` binary installation for versions >= `3.5.0`
Fix keys test suite to use ETCD_API=2 and `etcd` `3.3.19`

## 10.0.0 - *2025-06-06*

Increased default etcd version to `3.5.21`
Fix alma linux conflicting package errors when installing docker
`auto_compaction_retention` is now a string since etcd 3.3
Update expected test output based on new etcd version

## 9.2.2 - *2025-06-03*

Fix usage of `auto_compaction_retention` property in configuration file

## 9.2.0 - *2025-05-14*

* Add `config_file` property for service resources to enable the passing of configuration options through a [configuration file](https://etcd.io/docs/v3.5/op-guide/configuration/#configuration-file) instead of command-line flags

## 9.1.33 - *2024-11-18*

Standardise files with files in sous-chefs/repo-management

Standardise files with files in sous-chefs/repo-management

## 9.1.32 - *2024-07-15*

Standardise files with files in sous-chefs/repo-management

Standardise files with files in sous-chefs/repo-management

## 9.1.31 - *2024-05-22*

Standardise files with files in sous-chefs/repo-management

## 9.1.25 - *2024-02-17*

* Fix markdown links

## 9.1.21 - *2023-10-31*

* Fix markdown

## 9.1.14 - *2023-04-07*

Standardise files with files in sous-chefs/repo-management

## 9.1.11 - *2023-04-01*

Standardise files with files in sous-chefs/repo-management

## 9.1.10 - *2023-03-20*

Standardise files with files in sous-chefs/repo-management

## 9.1.9 - *2023-03-15*

Standardise files with files in sous-chefs/repo-management

## 9.1.7 - *2023-02-28*

* Add `experimental_peer_skip_client_san_verification` option to partial resources
* Splt out GH actions so docker suites run in vagrant and amazonlinux runs on 20.04 runners
* Set Chef version to 17 due to docker blocking on 18 due to [sous-chefs/docker#1229](https://github.com/sous-chefs/docker/pull/1229)

## 9.1.6 - *2023-02-23*

* Standardise files with files in sous-chefs/repo-management

## 9.1.5 - *2023-02-16*

* Standardise files with files in sous-chefs/repo-management

## 9.1.4 - *2023-02-15*

* Update Actions (#135)

## 9.1.3 - *2023-02-14*

* Standardise files with files in sous-chefs/repo-management

## 9.1.2 - *2023-02-14*

* Remove CircleCI (#133)
* Remove Gemfile

## 9.1.1 - *2022-12-10*

* Standardise files with files in sous-chefs/repo-management

## 9.1.0 - *2022-11-08*

* Add configuration flag [-experimental-peer-skip-client-san-verification](https://etcd.io/docs/latest/op-guide/configuration/#--experimental-peer-skip-client-san-verification)

## 9.0.1 - *2022-02-10*

* Standardise files with files in sous-chefs/repo-management
* Remove delivery folder

## 9.0.0 - *2021-12-01*

* Use partials instead of including a library.
   * Require Chef 16 for resource partials
* Remove unused libraries

## 8.0.0 - *2021-12-01*

* Remove Ubuntu 16.04 testing
* Remove OpenSUSE Leap testing
* Ignore deprecations as errors
* Remove `-debug` line from etcd_cmd as it is deprecated as of etcd 3.5.0 (#122)
* Set unified mode to be false, otherwise resources are not correctly being passed through to systemd resource (#120)

## 7.0.3 - *2021-11-03*

* Add CentOS Stream 8 to CI pipeline

## 7.0.2 - *2021-08-30*

* Standardise files with files in sous-chefs/repo-management

## 7.0.1 - *2021-06-01*

* Standardise files with files in sous-chefs/repo-management

## 7.0.0 - *2021-05-12*

* Chef 17 compatibility fixes
   * Set `unified_mode true` on all resources
   * Exclude `install_method` and `service_manager` methods when using `copy_properties_from`
* Require Chef 15.3+
* Remove backported `copy_properties_from` method library

## 6.3.0 - *2020-12-07*

* Add configuration flag listen-metrics-urls

## 6.2.0 - *2020-12-03*

* Cookstyle 7.1.2 fixes
* Update permissions to 0700 on data_dir

## 6.1.0 (2020-10-28)

### Changed

* Sous Chefs Adoption
* Update Changelog to Sous Chefs
* Update to use Sous Chefs GH workflow
* Update README to sous-chefs
* Update metadata.rb to Sous Chefs
* Update test-kitchen to Sous Chefs

### Fixed

* Cookstyle fixes
* Yamllint fixes
* MDL fixes
* Add missing include for `EtcdCookbook::EtcdCommonProperties` in `etcd_installation_binary`

### Removed

* Remove support for Amazon Linux 1
* Remove support for CentOS 6

## 6.0.0 (2020-06-10)

* Support systemd only / Remove sysv init and Upstart - [@tas50](https://github.com/tas50)
* Add Ubuntu 20.04 testing - [@tas50](https://github.com/tas50)

## 5.6.3 (2020-06-10)

* Add etcd checksums to support versions 3.3.19 and 3.4.6 - [@tasdikrahman](https://github.com/tasdikrahman)
* Add missing provides for Chef Infra Client 15 compatibility - [@tas50](https://github.com/tas50)

## 5.6.2 (2020-06-03)

* Make sure we have provides and resource_name for Chef 15 - [@tas50](https://github.com/tas50)

## 5.6.1 (2020-06-02)

* Adding peer-cert-allowed-cn new option in allowed resources properties
* use copy_properties_from API - [@lamont-granquist](https://github.com/lamont-granquist)
* Expand testing to new platforms - [@tas50](https://github.com/tas50)
* Require Chef 12.15+ - [@tas50](https://github.com/tas50)
* Cookstyle fixes including Chef Infra Client 16 compatibility - [@xorimabot](https://github.com/xorimabot)
   * resolved cookstyle error: resources/etcd_installation_docker.rb:1:1 warning: `ChefDeprecations/ResourceUsesOnlyResourceName`
   * resolved cookstyle error: resources/etcd_key.rb:3:1 warning: `ChefDeprecations/ResourceUsesOnlyResourceName`
   * resolved cookstyle error: resources/etcd_service.rb:3:1 warning: `ChefDeprecations/ResourceUsesOnlyResourceName`
   * resolved cookstyle error: resources/etcd_service_manager_docker.rb:3:1 warning: `ChefDeprecations/ResourceUsesOnlyResourceName`

## 5.6.0 (2018-08-07)

* Added etcd checksum to support version 3.2.17.

## 5.5.1 (2018-07-18)

* Add default_service_name param for etcd_service resource. Now you can change service name from
  etcd_NODE_NAME(set false by default) to etcd(set true)

## 5.5.0 (2018-03-09)

* Convert from HWRPs to standard custom resources which resolves several incompatibilities that occured with the upcoming Chef 14 release

## 5.4.0 (2018-03-09)

* Default to 3.2.15
* Make sure the service resource has a default action of :create
* Fixed handling of cert based auth
* Support storing data locally when using docker
* Wire-up service_timeout property to systemd timeoutstartsec
* Fix failing integration test
* Remove the ChefSpec matchers that are autogenerated now. If you see ChefSpec failures the fix is upgrading ChefDK.

## 5.3.1 (2018-01-28)

* Give etcd 120 seconds to start under systemd instead of the 60s default

## 5.3.0 (2018-01-13)

* Update the default etcd from 3.2.6 to 3.2.14
* Cleanup the test suites

## 5.2.1 (2017-12-02)

* Remove the start/wait logic from sys-v
* Fix checksum property on etcd_installation resource

## 5.2.0 (2017-09-11)

* Several changes have been made to the cookbook to better allow for building up new etcd clusters. Since etcd will loop waiting for quorum forever processes never hand control back to the init system when the first node is being built. To workaround this I have removed the healthcheck script that was previously bundled and added the ability to continue on after failures. To not fail when the service fails to start add ignore_failure true to the service_manager resource declaration (see the example in the readme) and Chef will continue allowing the cluster to complete its build out.
* Changed how the server_manager resources are declared to better support additional platforms that also use sys-v, upstart, or systemd. This gets us opensuse support, which is now part of the test matrix.
* Add docker testing to the test kitchen and remove the duplicate installation tests
* Fix new_resource error in the in etcd_service_manager_docker
* Resolve a deprecation warning in etcd_service_manager_docker
* Fix the etcd command to include the binary name in etcd_service_manage_docker

## 5.1.0 (2017-09-11)

* Be less specific in the service resources so we can support any platform that is systemd, upstart or sys-v
* Add that we support opensuse leap to the metadata / readme

## 5.0.0 (2017-09-05)

### Breaking Changes

* This cookbook has been refactored to work with etcd 3.X and now defaults to installing 3.2.6\. 2.x will not work as many new configuration properties have been added to etcd. If you need support for etcd 2.x you should pin the 4.X release of this cookbook.
* This cookbook now longer requires compat_resource and also utilizes the systemd_unit resource in Chef. Due to this the cookbook now requires Chef 12.11 or later.
* The execute provider for the etcd_service has been removed as Chef should not be used as an init system. There is now fully functional sys-v, upstart, and systemd support, which are preferred alternatives.

### Other Changes

* Listening ports in examples, tests, and resources have been updated for the new ports used by etcd
* Integration testing has been updated to InSpec
* The default path to the data dir is now an absolute path to resolve some previous issues
* All Chef 14 deprecation warnings have been resolved
* Remove the only_if on the service start that could potentially prevent the service from starting
* Sync up the unit file with the upstream format recommended by the project
* Fix faulty logfile logic in the upstart / sys-v scripts that prevented these resources from ever working

## 4.1.0 (2017-08-20)

* Fixing some deprecation warnings

## 4.1.0 (2016-10-10)

* suse is systemd not sysv
* Require Chef 12.1+ and the latest compat_resource
* Define custom matchers helpers for Chefspec

## 4.0.0

* Install etcd 2.3.7 by default
* Install tar to ensure we can decompress the etcd package
* Replace testing of Ubuntu 15.10 with 16.04
* Fix testing in Test Kitchen using vagrant
* Add a Gemfile with testing dependencies
* Update the compat_resource dependency from 12.5 to 12.10 to bring in the latest fixes
* Add chef_version metadata to the metadata.rb file

## 3.2.5

* Added Redhat, Oracle Linux, and Scientific Linux to the metadata
* Fixed issues_url and source_url in the metadata to point to the correct URL
* Added license to the metadata
* Updated Rakefile so testing tasks match other Chef cookbooks
* Add maintainers files and Rake task to generate the markdown

## 3.2.4

* Added support for Scientific / Oracle Linux 6.X
* Fixed readme badges
* Added a chefignore file
* Add contributing and testing docs
* Removed Ruby 2.2 via RVM install from the Travis CI runs

## 3.2.3

* Retrying key operations

## 3.2.2

* Using converge_if_changed in :set action

## 3.2.1

* Adding etcd_key resource
* Removing unused property previous_state
* Adding desired_state: false to various properties

## 3.2.0

* Adding etcd_key resource

## 3.1.6

* Fix redirecting stderr to stdout in upstart manaager

## 3.1.5

* Fix timeout pattern in systemd-wait-ready

## 3.1.4

* Fixing up docker service manager tests

## 3.1.3

* Fixing incorrectly named classes in service managers

## 3.1.2

* Fixing wait-ready script to use etcdctl_cmd

## 3.1.1

* Adding docker to etcd_service

## 3.1.0

* Supporting run_user on service manager resources

## 3.0.0

* New major version, non-backwards compatible with 2.x.x
* Rewritten as Custom Resources
* Defaulting to etcd version 2.2.2

## 2.2.2

* update to etcd 0.4.6
* adds debian support

## 2.2.1

* update to etcd 0.4.5
* Add centos 7 support
* Support centos cloud images without tar
* Dry out compile time recipe
* Move to berks3

## 2.2.0

* update to etcd 0.4.2
* Removed node[:etcd][:local] No longer needed in new etcd. Etcd will default bind :4001 and :7001.
* The cookbook default is now to use node[:ipaddress] as the addr and peer_addr.
* add auto-respawn instruction in upstart config file
* Fix Gem deps in the ci build

## 2.1.3

* add peer and peer_addr support / attributes
* add name attribute and computation
* fixup cmdline argument computation
* ensure cluster members are always sorted
* fix spec tests

## 2.1.2

* fix bug in cluster recipe where Resolv was spelled wrong
* fix kitchen test on cluster to pickup this issue.
* add basic chefspec as well to ensure this sort of issue doesn't occur
* fix bug with name attribute methods
* fix searching for wrong recipe when using cluster recipe

## 2.1.1

* update to etcd 0.3.0
* Add support for new discovery mode
* refactor common functions into library methods
* Add specs
* Use rubocop to replace tailor/cane
* Fixup testing (add travis integration)

## 2.0.0

* update to etcd 0.2.0
* remove `name_switch` attribute. It was marked for deprication in 1.3
* enable snapshotting by default
* add optional local listener
* support chef-solo
* Add support of explicitely specifying a cluster's nodes

## 1.3.5

* silence foodcritic by accessing attributes in a consistent manner,
* trigger a restart when etcd conf is updated
* include git if source install
* metadata depends on git recipe
* Update Documentation
* Update contributors

## 1.3.4

* fix compile_time to use the right tarball path

## 1.3.3

* Bump to etcd 1.2
* Added source install recipe

## 1.3.1

* default binding to node[:ipaddress]

## 1.2.4

* update to etcd 0.1.1 release
* add compile_time recipe that does the whole bit in chef compile time

## 1.2.3

* hotfix to add missing `node[:etcd][:env_scope]` attribute
* bugfix: use `node[:fqdn]` instead of hostname when matching local machine name

## 1.2.2

* add cluster recipe for setting up clusters of etcd nodes
* re-add seed-node attribute

## 1.2.1

* fix the startup args so it is easier to specify custom args
* supports release version and current master on git
* add in tests for both release and git versions of etcd

## 1.1.1

* Make everything work with release 0.1.0 of etcd
* fixup some syntax issues

## 1.1.0

* move binary install to using coreos/etcd releases from github
* for now the install locattion is fixed to /usr/local and links in /usr/local/bin
* Use ark for managing tarballs
* move bats tests to using etcdctl instead of curl
