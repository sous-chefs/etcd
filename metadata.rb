name 'etcd'
maintainer 'Chef Software, Inc.'
maintainer_email 'cookbooks@chef.io'
license 'Apache-2.0'
description 'Installs and configures etcd'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '5.6.0'

depends 'docker'

%w(ubuntu debian redhat centos suse opensuse opensuseleap scientific oracle amazon).each do |os|
  supports os
end

source_url 'https://github.com/chef-cookbooks/etcd'
issues_url 'https://github.com/chef-cookbooks/etcd/issues'
chef_version '>= 12.11'
