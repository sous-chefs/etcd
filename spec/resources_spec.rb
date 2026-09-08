# frozen_string_literal: true

require 'spec_helper'

describe 'etcd resources' do
  platform 'ubuntu', '24.04'

  context 'binary installation' do
    step_into :etcd_installation_binary
    recipe { etcd_installation_binary 'default' }

    it 'downloads the verified default release' do
      expect(chef_run).to create_remote_file("#{Chef::Config[:file_cache_path]}/etcd-v3.7.1-linux-amd64.tar.gz").with(
        checksum: 'e8cd3fa8064c98137c5dbd78b76f969417ace84efb83c481041d7a52ffdd8fb9'
      )
    end

    it 'extracts all three binaries' do
      %w(etcd etcdctl etcdutl).each { |binary| expect(chef_run).to run_execute("extract #{binary}") }
    end
  end

  context 'binary deletion' do
    step_into :etcd_installation_binary
    recipe do
      etcd_installation_binary 'default' do
        action :delete
      end
    end

    it 'removes binaries and the downloaded archive' do
      %w(etcd etcdctl etcdutl).each { |binary| expect(chef_run).to delete_file("/usr/bin/#{binary}") }
      expect(chef_run).to delete_file("#{Chef::Config[:file_cache_path]}/etcd-v3.7.1-linux-amd64.tar.gz")
    end
  end

  context 'docker installation' do
    step_into :etcd_installation_docker
    recipe { etcd_installation_docker 'default' }

    it 'pulls the requested image' do
      expect(chef_run).to pull_docker_image('etcd').with(repo: 'quay.io/coreos/etcd', tag: 'v3.7.1')
    end
  end

  context 'docker service' do
    step_into :etcd_service_manager_docker
    recipe { etcd_service_manager_docker 'example' }

    it 'uses a separate data directory for each instance' do
      expect(chef_run).to create_directory('/var/lib/etcd/example')
      expect(chef_run).to run_docker_container('etcd-example').with(volumes_binds: ['/var/lib/etcd/example:/example.etcd'])
    end
  end

  context 'service wrapper' do
    step_into :etcd_service
    recipe do
      etcd_service 'example' do
        install_method 'docker'
        service_manager 'docker'
        action [:create, :start]
      end
    end

    it 'dispatches both docker resources' do
      expect(chef_run).to create_etcd_installation_docker('example')
      expect(chef_run).to start_etcd_service_manager_docker('example')
    end
  end

  context 'service deletion' do
    step_into :etcd_service
    recipe do
      etcd_service 'example' do
        action :delete
      end
    end

    it 'deletes the service and its installation' do
      expect(chef_run).to delete_etcd_service_manager('example')
      expect(chef_run).to delete_etcd_installation('example')
    end
  end
end
