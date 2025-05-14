describe command('etcdctl member list') do
  its(:exit_status) { should eq 0 }
  its(:stdout) { should match(%r{name=default peerURLs=http://localhost:2380 clientURLs=http://localhost:2379}) }
end

control 'Check etcd configuration' do
  describe yaml('/etc/etcd/etcd-default.conf.yml') do
    its('name') { should eq 'default' }
    its('data-dir') { should eq '/default.etcd' }
    its('listen-peer-urls') { should eq 'http://localhost:2380' }
    its('listen-client-urls') { should eq 'http://localhost:2379' }
  end
end

control 'Check etcd service' do
  describe file('/etc/systemd/system/etcd-default.service') do
    its('content') do
      should match(%r{^ExecStart=/usr/bin/etcd --config-file /etc/etcd/etcd-default.conf.yml$})
    end
  end
end
