# frozen_string_literal: true

require 'spec_helper'
require 'erb'
require 'yaml'

describe 'etcd YAML configuration' do
  %w(3.6.6 3.7.1).each do |version|
    it "gates v2 discovery for #{version} while retaining DNS discovery" do
      context = Object.new
      context.instance_variable_set(:@version, version)
      context.instance_variable_set(:@discovery, 'https://discovery.example/token')
      context.instance_variable_set(:@discovery_srv, 'example.test')
      rendered = ERB.new(File.read(File.expand_path('../templates/default/config/etcd.conf.yml.erb', __dir__))).result(context.instance_eval { binding })
      config = YAML.safe_load(rendered)
      expect(config['discovery-srv']).to eq('example.test')
      expect(config.key?('discovery')).to eq(version.start_with?('3.6'))
      expect(config.keys).not_to include('enable-v2', 'proxy', 'discovery-fallback')
    end
  end
end
