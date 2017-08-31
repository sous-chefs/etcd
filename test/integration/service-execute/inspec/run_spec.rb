describe command('etcdctl member list') do
  its(:exit_status) { should eq 0 }
  its(:stdout) { should match(%r{name=default peerURLs=http://localhost:2380 clientURLs=http://localhost:2379 isLeader=true}) }
end
