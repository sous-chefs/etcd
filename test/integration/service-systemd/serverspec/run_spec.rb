require 'serverspec'

set :backend, :exec
puts "os: #{os}"

describe command('etcdctl member list') do
  its(:exit_status) { should eq 0 }
  its(:stdout) { should match(%r{name=default peerURLs=http://localhost:2380,http://localhost:7001 clientURLs=http://localhost:2379,http://localhost:4001}) }
end
