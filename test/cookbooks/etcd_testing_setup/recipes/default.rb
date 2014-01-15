

if node[:platform] == "ubuntu"
  include_recipe "ubuntu"
end

if node[:platform_family] == "redhat"
  include_recipe "yum-epel"
end

include_recipe "curl"
