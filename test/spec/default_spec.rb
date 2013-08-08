require 'chefspec'

describe 'test_cook_skeleton::default' do
  let(:chef_run) { ChefSpec::ChefRunner.new.converge 'test_cook_skeleton::default' }
  it 'does something' do
    pending 'Your recipe examples go here.'
  end
end
