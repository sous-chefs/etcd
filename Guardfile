require 'guard/guard'
require 'mixlib/shellout'
require 'safe_yaml'
require 'guard/kitchen'
SafeYAML::OPTIONS[:deserialize_symbols] = true

guard 'rake', :task => 'test:quick' do
  watch(%r{^test/spec/.+_spec\.rb$})
  watch(%r{^lib/(.+)\.rb$})     { |m| "test/spec/lib/#{m[1]}_spec.rb" }
  watch('test/spec/spec_helper.rb')  { "test/spec" }
  watch(%r{^recipes/(.+)\.rb$}) { |m| "test/spec/unit/recipes/#{m[1]}_spec.rb" }
  watch(%r{^attributes/(.+)\.rb$})
  watch(%r{^files/(.+)})
  watch(%r{^templates/(.+)})
  watch(%r{^providers/(.+)\.rb}) { |m| "test/spec/unit/providers/#{m[1]}_spec.rb" }
  watch(%r{^resources/(.+)\.rb}) { |m| "test/spec/unit/resources/#{m[1]}_spec.rb" }
end

guard 'kitchen' do
  watch(%r{test/[^spec].+})
  watch(%r{^lib/(.+)\.rb$})
  watch('spec/spec_helper.rb')  { "test/spec" }
  watch(%r{^recipes/(.+)\.rb$}) { |m| "test/spec/unit/recipes/#{m[1]}_spec.rb" }
  watch(%r{^attributes/(.+)\.rb$})
  watch(%r{^files/(.+)})
  watch(%r{^templates/(.+)})
  watch(%r{^providers/(.+)\.rb}) { |m| "test/spec/unit/providers/#{m[1]}_spec.rb" }
  watch(%r{^resources/(.+)\.rb}) { |m| "test/spec/unit/resources/#{m[1]}_spec.rb" }
end
