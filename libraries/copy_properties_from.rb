# THIS IS BACKPORTED FROM CHEF-15, NO PATCHES AGAINST THIS WILL BE ACCEPTED
# ONCE CHEF-14 IS NO LONGER SUPPORTED THIS FILE SHOULD BE DELETED

unless Chef::Resource.method_defined?(:copy_properties_from)
  class Chef
    class Resource
      def copy_properties_from(other, *includes, exclude: [ :name ])
        includes = other.class.properties.keys if includes.empty?
        includes -= exclude
        includes.each do |p|
          send(p, other.send(p)) if other.property_is_set?(p)
        end
        self
      end
    end
  end
end
