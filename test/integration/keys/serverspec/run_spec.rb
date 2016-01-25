require 'serverspec'

set :backend, :exec

describe command('etcdctl get /test') do
  its(:exit_status) { should eq 0 }
  its(:stdout) { should eql("a_test_value\n") }
end

describe command('etcdctl get /delete') do
  its(:exit_status) { should eq 4 }
  its(:stderr) { should match(/^Error:  100: Key not found/) }
end
