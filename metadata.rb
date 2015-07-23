name 'etcd'
source_url "https://github.com/chef-brigade/#{name}-cookbook" if respond_to?(:source_url)
issues_url "https://github.com/chef-brigade/#{name}-cookbook/issues" if respond_to?(:issues_url)
maintainer 'Chef Brigade'
maintainer_email 'help@chefbrigade.io'
version '2.2.2'

depends 'ark'
depends 'partial_search', '~> 1.0.6'
depends 'git'
depends 'chef-sugar'
