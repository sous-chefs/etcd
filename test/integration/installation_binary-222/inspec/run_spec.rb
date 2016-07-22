describe command('/usr/bin/etcd --version') do
  its(:exit_status) { should eq 0 }
  its(:stdout) { should match(/2.3.7/) }
end

describe command('/usr/bin/etcdctl --version') do
  its(:exit_status) { should eq 0 }
  its(:stdout) { should match(/2.3.7/) }
end
