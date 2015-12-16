require 'serverspec'

set :backend, :exec
puts "os: #{os}"

describe command('docker images | grep quay.io/coreos/etcd') do
  its(:exit_status) { should eq 0 }
  its(:stdout) { should match(%r{quay.io/coreos/etcd}) }
end
