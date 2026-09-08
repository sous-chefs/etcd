# frozen_string_literal: true

require 'spec_helper'

describe 'etcd_key' do
  platform 'ubuntu', '24.04'
  step_into :etcd_key

  let(:key_class) { Chef::Resource.resource_for_node(:etcd_key, chef_runner.node) }
  let(:current) { { 'kvs' => [{ 'value' => Base64.strict_encode64('same'), 'lease' => 0 }] } }

  before do
    allow_any_instance_of(key_class).to receive(:client_json).with('get', '--', '/test').and_return(current)
  end

  context 'unchanged value' do
    recipe do
      etcd_key '/test' do
        value 'same'
      end
    end

    it 'does not write an unchanged key' do
      expect_any_instance_of(key_class).not_to receive(:client_json).with('put', '--', '/test', input: 'same')
      expect(chef_run.etcd_key('/test')).not_to be_updated_by_last_action
    end
  end

  context 'missing value' do
    let(:current) { { 'kvs' => [] } }
    recipe do
      etcd_key '/test' do
        value 'new value'
      end
    end

    it 'writes through v3 without putting the value in the command line' do
      expect_any_instance_of(key_class).to receive(:client_json).with('put', '--', '/test', input: 'new value').and_return({})
      expect(chef_run.etcd_key('/test')).to be_updated_by_last_action
    end
  end

  context 'delete' do
    recipe do
      etcd_key '/test' do
        action :delete
      end
    end

    it 'deletes an existing key' do
      expect_any_instance_of(key_class).to receive(:client_json).with('del', '--', '/test').and_return({})
      expect(chef_run.etcd_key('/test')).to be_updated_by_last_action
    end
  end
  context 'missing deletion' do
    let(:current) { { 'kvs' => [] } }
    recipe do
      etcd_key '/test' do
        action :delete
      end
    end

    it 'does not delete a missing key' do
      expect_any_instance_of(key_class).not_to receive(:client_json).with('del', '--', '/test')
      expect(chef_run.etcd_key('/test')).not_to be_updated_by_last_action
    end
  end

  context 'lease creation' do
    let(:current) { { 'kvs' => [] } }
    recipe do
      etcd_key '/test' do
        value 'temporary'
        ttl 60
      end
    end

    it 'attaches the granted v3 lease using its hexadecimal ID' do
      expect_any_instance_of(key_class).to receive(:client_json).with('lease', 'grant', '60').and_return('ID' => 255)
      expect_any_instance_of(key_class).to receive(:client_json).with('put', '--lease=ff', '--', '/test', input: 'temporary').and_return({})
      expect(chef_run.etcd_key('/test')).to be_updated_by_last_action
    end
  end

  context 'connection failure' do
    recipe do
      etcd_key '/test' do
        value 'same'
      end
    end

    it 'fails instead of treating the key as absent' do
      allow_any_instance_of(key_class).to receive(:client_json).with('get', '--', '/test').and_raise(Errno::ECONNREFUSED)
      expect { chef_run }.to raise_error(Errno::ECONNREFUSED)
    end
  end
  context 'unchanged leased value' do
    let(:current) { { 'kvs' => [{ 'value' => Base64.strict_encode64('same'), 'lease' => 255 }] } }
    recipe do
      etcd_key '/test' do
        value 'same'
        ttl 60
      end
    end

    it 'uses the granted-ttl field and retains the existing lease' do
      allow_any_instance_of(key_class).to receive(:client_json).with('lease', 'timetolive', 'ff').and_return('ttl' => 55, 'granted-ttl' => 60)
      expect_any_instance_of(key_class).not_to receive(:client_json).with('lease', 'grant', '60')
      expect(chef_run.etcd_key('/test')).not_to be_updated_by_last_action
    end
  end
end
