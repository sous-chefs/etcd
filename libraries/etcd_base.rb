module EtcdCookbook
  class EtcdBase < ChefCompat::Resource
    require 'helpers_base'

    ################
    # Type Constants
    ################

    Boolean = property_type(
      is: [true, false],
      default: false
    ) unless defined?(Boolean)

    declare_action_class
  end
end
