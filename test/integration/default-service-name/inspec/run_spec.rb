describe command('etcdctl member list') do
  its(:exit_status) { should eq 0 }
  its(:stdout) { should match(%r{started, default, http://localhost:2380, http://localhost:2379}) }
end

describe file('/etc/systemd/system/etcd.service') do
  it { should exist }
end
