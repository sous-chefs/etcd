require 'serverspec'

set :backend, :exec
puts "os: #{os}"

describe command('ps -ef | grep -v grep | grep ^alice | grep etcd') do
  its(:exit_status) { should eq 0 }
end

describe command('ps -ef | grep -v grep | grep ^bob | grep etcd') do
  its(:exit_status) { should eq 0 }
end

describe command('ps -ef | grep -v grep | grep ^eve | grep etcd') do
  its(:exit_status) { should eq 0 }
end

describe command('etcdctl member list') do
  its(:exit_status) { should eq 0 }
  its(:stdout) { should match(%r{name=etcd0 peerURLs=http://127.0.0.1:2380 clientURLs=http://127.0.0.1:2379,http://127.0.0.1:4001}) }
  its(:stdout) { should match(%r{name=etcd1 peerURLs=http://127.0.0.1:3380 clientURLs=http://127.0.0.1:3379,http://127.0.0.1:5001}) }
  its(:stdout) { should match(%r{name=etcd2 peerURLs=http://127.0.0.1:4380 clientURLs=http://127.0.0.1:4379,http://127.0.0.1:6001}) }
end
