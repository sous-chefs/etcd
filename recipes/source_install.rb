#
# Installs etcd from source
#

# install go
include_recipe 'golang::default'

# checkout etcd from git
git "#{Chef::Config[:file_cache_path]}/etcd" do
  repository node[:etcd][:source][:repo]
  reference node[:etcd][:source][:revision]
  action :sync
  notifies :run, "bash[compile_etcd]"
end

git "#{Chef::Config[:file_cache_path]}/etcdctl" do
  repository node[:etcdctl][:source][:repo]
  reference node[:etcdctl][:source][:revision]
  action :sync
  notifies :run, "bash[compile_etcdctl]"
end

# build and 'install'
bash "compile_etcd" do
  user "root"
  cwd "#{Chef::Config[:file_cache_path]}/etcd"
  code <<-EOH
  ./build
  mv etcd /usr/local/bin/
  EOH
end

bash "compile_etcdctl" do
  user "root"
  cwd "#{Chef::Config[:file_cache_path]}/etcdctl"
  code <<-EOH
  ./build
  mv etcdctl /usr/local/bin/
  EOH
end
