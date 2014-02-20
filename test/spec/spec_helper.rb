cfg_dir = File.expand_path(File.dirname(__FILE__) + "../../")
$: << cfg_dir

if ENV["COVERAGE"]
  require "simplecov"

  SimpleCov.start do
    add_filter "spec"
  end
end

require "chefspec"
require 'chefspec/server'

RSpec.configure do |config|
  config.platform = 'centos'
  config.version = '6.4'
  config.color = true
  config.cookbook_path = "#{cfg_dir}/../.cooks"
end
