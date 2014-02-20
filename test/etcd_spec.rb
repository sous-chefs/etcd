require_relative 'spec_server_helper'
require_relative '../../libraries/etcd'

describe 'etcd::default' do
    let(:chef_run) { ChefSpec::Runner.new }
    let(:node) { chef_run.node }

    before(:each) do
      Chef::Recipe::Etcd.node = chef_run.node
    end

  context 'package_name' do
    it 'handles version variance' do
      node.set[:etcd][:version] = '1.3.0'
      expect(Chef::Recipe::Etcd.package_name).to eql 'etcd-v1.3.0-linux-amd64.tar.gz'
      node.set[:etcd][:version] = '0.3.0'
      expect(Chef::Recipe::Etcd.package_name).to eql 'etcd-v0.3.0-linux-amd64.tar.gz'
      node.set[:etcd][:version] = '0.2.0'
      expect(Chef::Recipe::Etcd.package_name).to eql 'etcd-v0.2.0-Linux-x86_64.tar.gz'
      node.set[:etcd][:version] = '0.0.1'
      expect(Chef::Recipe::Etcd.package_name).to eql 'etcd-v0.0.1-Linux-x86_64.tar.gz'
    end
  end


  context 'local_cmd' do
    it 'binds all ints when local is set' do
      node.set[:etcd][:local] = true
      Chef::Recipe::Etcd.local_cmd.should eql ' -bind-addr 0.0.0.0 -peer-bind-addr 0.0.0.0'
    end

    it 'returns nil when not set' do
      node.set[:etcd][:local] = false
      Chef::Recipe::Etcd.local_cmd.should eql nil
    end
  end

  context 'discovery_cmd' do
    it 'should default to empty string' do
      node.set[:etcd][:discovery] = ''
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
    end

  end

  context 'args' do
    it 'recognizes local mode' do
      node.set[:etcd][:local] = true
      node.set[:etcd][:discovery] = ''
      node.set[:etcd][:args] = ''
      Chef::Recipe::Etcd.args.should eql ' -bind-addr 0.0.0.0 -peer-bind-addr 0.0.0.0 -peers-file=/etc/etcd_members'
    end

    it 'toggles discovery' do
      node.set[:etcd][:local] = true
      node.set[:etcd][:discovery] = '1.1.1.1'
      node.set[:etcd][:args] = ''
      Chef::Recipe::Etcd.args.should eql %Q{ -bind-addr 0.0.0.0 -peer-bind-addr 0.0.0.0 -discovery='1.1.1.1'}
    end
  end
end
