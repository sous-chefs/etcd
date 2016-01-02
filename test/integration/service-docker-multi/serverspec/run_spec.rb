require 'serverspec'

set :backend, :exec
puts "os: #{os}"

describe command('etcdctl member list') do
  its(:exit_status) { should eq 0 }
  its(:stdout) { should match(%r{name=etcd2 peerURLs=http://127.0.0.1:4380 clientURLs=http://0.0.0.0:6001,http://127.0.0.1:4379}) }
  its(:stdout) { should match(%r{name=etcd0 peerURLs=http://127.0.0.1:2380 clientURLs=http://0.0.0.0:4001,http://127.0.0.1:2379}) }
  its(:stdout) { should match(%r{name=etcd1 peerURLs=http://127.0.0.1:3380 clientURLs=http://0.0.0.0:5001,http://127.0.0.1:3379}) }
end
