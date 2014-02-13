$: << File.expand_path(File.dirname(__FILE__) + "../../")

if ENV["COVERAGE"]
  require "simplecov"

  SimpleCov.start do
    add_filter "spec"
  end
end

require "chefspec"
require 'chefspec/berkshelf'

RSpec.configure do |config|
  config.platform = 'centos'
  config.version = '6.4'
  config.color = true
end
