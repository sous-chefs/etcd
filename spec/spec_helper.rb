# frozen_string_literal: true

require 'chefspec'
require 'chefspec/policyfile'

RSpec.configure do |config|
  config.platform = 'ubuntu'
  config.version = '24.04'
end
