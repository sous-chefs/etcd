describe command('etcdctl member list') do
  its(:exit_status) { should eq 0 }
  its(:stdout) { should match(%r{started, etcd0, http://127.0.0.1:2380, http://127.0.0.1:2379}) }
  its(:stdout) { should match(%r{started, etcd1, http://127.0.0.1:3380, http://127.0.0.1:3379}) }
  its(:stdout) { should match(%r{started, etcd2, http://127.0.0.1:4380, http://127.0.0.1:4379}) }
end
