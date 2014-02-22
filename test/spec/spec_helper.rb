cook_dir = File.expand_path(File.dirname(__FILE__) + "../../../.cooks")
require "chefspec"
require 'chefspec/server'

RSpec.configure do |config|
  config.platform = 'ubuntu'
  config.version = '12.04'
  config.color = true
  config.cookbook_path = cook_dir
end
