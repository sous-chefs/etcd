require_relative 'spec_helper.rb'

describe 'etcd::cluster' do
  before do
    ::Resolv.stub(:getaddress).and_return('127.0.0.1', '127.0.0.2', '127.0.0.3')
  end

  it 'searches  members' do
    # TODO: this doesn't work quite right. I belive because recipes doens't expand right
    rl = { run_list: ['recipe[etcd::cluster]']}
    ChefSpec::Server.create_node("node1", rl)
    ChefSpec::Server.create_node("node2", rl)
    chef_run = ChefSpec::Runner.new.converge(described_recipe)
    # TODO: this should be asserting on the search, but it doesn't
    expect(chef_run).to create_file('/etc/etcd_members')#.with_content("127.0.0.2:7001, 127.0.0.3:7001")
  end

  it 'honors manual node specification' do
    ::Resolv.stub(:getaddress).and_return('127.0.0.1', '127.0.0.2', '127.0.0.3')
    chef_run = ChefSpec::Runner.new do |node|
      node.set[:etcd][:nodes] = %w{ node1 node2 }
    end.converge(described_recipe)
    # todo this is a bit brittle
    expect(chef_run).to create_file('/etc/etcd_members').with_content("127.0.0.2:7001,127.0.0.3:7001")
  end

  it 'includes etcd recipe and returns when discovery is set' do
    chef_run = ChefSpec::Runner.new do |node|
      node.set[:etcd][:discovery] = 'f308914ac250f4adc9d4e9cdfa70e9c7'
    end.converge(described_recipe)
    expect(chef_run).to include_recipe('etcd')
    expect(chef_run).not_to create_file('/etc/etcd_members')
  end
end
