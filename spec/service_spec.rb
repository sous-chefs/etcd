# frozen_string_literal: true

require 'spec_helper'

describe 'etcd_service_manager_systemd' do
  platform 'ubuntu', '24.04'
  step_into :etcd_service_manager_systemd

  context 'configuring secure discovery' do
    recipe do
      etcd_service_manager_systemd 'discovery' do
        discovery_endpoints 'https://discovery.example:2379'
        discovery_dial_timeout 1_000_000_000
        discovery_request_timeout 2_000_000_000
        discovery_keepalive_time 3_000_000_000
        discovery_keepalive_timeout 4_000_000_000
        discovery_insecure_transport false
      end
    end

    it 'passes duration units to the etcd CLI' do
      command = chef_run.systemd_unit('etcd-discovery.service').content[:Service][:ExecStart]
      expect(command).to include('-discovery-dial-timeout=1000000000ns')
      expect(command).to include('-discovery-request-timeout=2000000000ns')
      expect(command).to include('-discovery-keepalive-time=3000000000ns')
      expect(command).to include('-discovery-keepalive-timeout=4000000000ns')
    end

    it 'explicitly disables insecure discovery transport' do
      command = chef_run.systemd_unit('etcd-discovery.service').content[:Service][:ExecStart]
      expect(command).to include('-discovery-insecure-transport=false')
    end
  end

  context 'stopping an instance' do
    recipe do
      etcd_service_manager_systemd 'example' do
        action :stop
      end
    end

    it 'stops the systemd unit' do
      expect(chef_run).to stop_systemd_unit('etcd-example.service')
    end
  end

  context 'restarting an instance' do
    recipe do
      etcd_service_manager_systemd 'example' do
        action :restart
      end
    end

    it 'restarts the existing systemd unit' do
      expect(chef_run).to restart_systemd_unit('etcd-example.service')
    end
  end
  context 'deleting an instance' do
    recipe do
      etcd_service_manager_systemd 'example' do
        config_file '/etc/etcd/example.yml'
        wal_dir '/var/lib/etcd-wal/example'
        action :delete
      end
    end

    it 'removes configuration, data, WAL, logs and the legacy marker' do
      expect(chef_run).to delete_file('/etc/etcd/example.yml')
      expect(chef_run).to delete_directory('/example.etcd')
      expect(chef_run).to delete_directory('/var/lib/etcd-wal/example')
      expect(chef_run).to delete_file('/var/log/etcd-example.log')
      expect(chef_run).to delete_file('/etc/etcd-example-firstconverge')
    end
  end
end
