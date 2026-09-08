# frozen_string_literal: true

require 'spec_helper'
require_relative '../libraries/helpers_service'

describe EtcdCookbook::EtcdHelpers::Service do
  subject(:helper) { Object.new.extend(described_class) }

  %w(3.5.21 3.6.6 3.7.1).each do |version|
    context "etcd #{version}" do
      let(:resource) { double(version: version, discovery: 'https://discovery.example/token', discovery_srv: 'example.test') }

      before do
        allow(helper).to receive(:new_resource).and_return(resource)
        allow(resource).to receive(:method_missing).and_return(nil)
      end

      it 'gates the removed legacy discovery flag while preserving DNS discovery' do
        options = helper.etcd_daemon_opts
        expect(options).to include('-discovery-srv=example.test')
        if version.start_with?('3.7')
          expect(options).not_to include('-discovery=https://discovery.example/token')
        else
          expect(options).to include('-discovery=https://discovery.example/token')
        end
      end
    end
  end
end
