require 'serverspec'

set :backend, :exec
puts "os: #{os}"

describe command('/usr/bin/etcd --version') do
  its(:exit_status) { should eq 0 }
  its(:stdout) { should match(/2.2.2/) }
end

describe command('/usr/bin/etcdctl --version') do
  its(:exit_status) { should eq 0 }
  its(:stdout) { should match(/2.2.2/) }
end
