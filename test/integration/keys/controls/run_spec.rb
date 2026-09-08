# frozen_string_literal: true

describe command('etcdctl get /test --print-value-only') do
  its(:exit_status) { should eq 0 }
  its(:stdout) { should eql("a_test_value\n") }
end

describe command('etcdctl get /delete') do
  its(:exit_status) { should eq 0 }
  its(:stdout) { should eq '' }
end

describe command('etcdctl get /leased --print-value-only') do
  its(:exit_status) { should eq 0 }
  its(:stdout) { should eql("temporary\n") }
end
