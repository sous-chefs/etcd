require_relative 'spec_helper'
require_relative '../../libraries/etcd'

describe 'Etcd' do
  let(:chef_run) { ChefSpec::Runner.new }
  let(:node) { chef_run.node }
  before(:each) do
    Chef::Recipe::Etcd.node = chef_run.node
  end

  context 'package_name' do

    it 'handles version variance' do
      chef_run = ChefSpec::Runner.new
      node = chef_run.node
      Chef::Recipe::Etcd.node = chef_run.node
      node.set[:etcd][:version] = '1.3.0'
      expect(Chef::Recipe::Etcd.package_name).to eql 'etcd-v1.3.0-linux-amd64.tar.gz'
      node.set[:etcd][:version] = '0.3.0'
      expect(Chef::Recipe::Etcd.package_name).to eql 'etcd-v0.3.0-linux-amd64.tar.gz'
      node.set[:etcd][:version] = '0.2.0'
      expect(Chef::Recipe::Etcd.package_name).to eql 'etcd-v0.2.0-Linux-x86_64.tar.gz'
      node.set[:etcd][:version] = '0.0.1'
      expect(Chef::Recipe::Etcd.package_name).to eql 'etcd-v0.0.1-Linux-x86_64.tar.gz'
    end
    
    it ' raises when version is nil or invalid' do
      node.set[:etcd][:version] = nil
      expect {Chef::Recipe::Etcd.package_name}.to raise_error
    end
  end

  context 'local_cmd' do
    it 'binds all ints when local is set' do
      node.set[:etcd][:local] = true
      Chef::Recipe::Etcd.local_cmd.should eql ' -bind-addr 0.0.0.0 -peer-bind-addr 0.0.0.0'
    end

    it 'empty when not set' do
      node.set[:etcd][:local] = false
      Chef::Recipe::Etcd.local_cmd.should eql ''
    end
  end

  context 'discovery_cmd' do
    it 'should default to empty string' do
      node.set[:etcd][:discovery] = ''
      node.set[:etcd][:nodes] = []
      Chef::Recipe::Etcd.slave = false
      Chef::Recipe::Etcd.discovery_cmd.should eql ''
    end

    it 'sets up when we have a uuid' do
      node.set[:etcd][:discovery] = '123456'
      Chef::Recipe::Etcd.discovery_cmd.should eql %Q{ -discovery='123456'}
    end

    it 'should setup peers when we are a slave and discovery is disabled.' do
      node.set[:etcd][:discovery] = ''
      Chef::Recipe::Etcd.slave = true
      Chef::Recipe::Etcd.discovery_cmd.should eql ' -peers-file=/etc/etcd_members'
      Chef::Recipe::Etcd.slave = false
    end

  end

  context 'args' do
    before do
      chef_run = ChefSpec::Runner.new
      chef_run.converge('etcd')
      Chef::Recipe::Etcd.node = chef_run.node
    end

    it 'recognizes local mode' do
      Chef::Recipe::Etcd.slave = false
      Chef::Recipe::Etcd.args.should eql ' -bind-addr 0.0.0.0 -peer-bind-addr 0.0.0.0 -name fauxhai.local -snapshot=true'

      Chef::Recipe::Etcd.slave = true
      Chef::Recipe::Etcd.args.should eql ' -bind-addr 0.0.0.0 -peer-bind-addr 0.0.0.0 -name fauxhai.local -peers-file=/etc/etcd_members -snapshot=true'
    end

    it 'toggles discovery' do
      chef_run = ChefSpec::Runner.new
      chef_run.node.set[:etcd][:discovery] = '1.1.1.1'
      chef_run.converge('etcd')
      Chef::Recipe::Etcd.args.should eql %Q{ -bind-addr 0.0.0.0 -peer-bind-addr 0.0.0.0 -name fauxhai.local -discovery='1.1.1.1' -snapshot=true}
    end
  end
end
