require_relative 'spec_helper.rb'

describe 'etcd::cluster' do
  let(:chef_run) { ChefSpec::Runner.new }


  before do
    ::Resolv.stub(:getaddress).and_return('127.0.0.1')
  end

  it 'includes etcd recipe and returns when discovery is set' do
    chef_run.node.set[:etcd][:discovery] = 'f308914ac250f4adc9d4e9cdfa70e9c7'
    chef_run.converge(described_recipe)
    expect(chef_run).to include_recipe('etcd')
    expect(chef_run).not_to create_file('/etc/etcd_members')
  end

  it 'finds cluster hosts' do
    ChefSpec::Server.create_client('bacon', { name: 'bacon' })
    puts node_1.inspect
    ChefSpec::Server.create_node(node_2, rl)
#    chef_run.node.set[:etcd][:env_scope] = false
#    chef_run.node.set[:etcd][:seed_node] = chef_run.node[:fqdn]
    ::Resolv.stub(:getaddress).and_return('127.0.0.1', '127.0.0.2')
    chef_run.converge(described_recipe)
    expect(chef_run).to create_file('/etc/etcd_members').with_content('127.0.0.1,127.0.0.2')
  end
end
