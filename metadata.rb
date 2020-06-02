name 'etcd'
maintainer 'Chef Software, Inc.'
maintainer_email 'cookbooks@chef.io'
license 'Apache-2.0'
description 'Installs and configures etcd'
version '5.6.1'

depends 'docker'

%w(ubuntu debian redhat centos suse opensuse opensuseleap scientific oracle amazon).each do |os|
  supports os
end

source_url 'https://github.com/chef-cookbooks/etcd'
issues_url 'https://github.com/chef-cookbooks/etcd/issues'
chef_version '>= 12.15'
