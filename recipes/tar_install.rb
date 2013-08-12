#
# Installs etcd from a tar
#

cache_path = Chef::Config[:file_cache_path]
tar_file = "#{cache_path}/#{File.basename node[:etcd][:url]}"

remote_file tar_file do
  mode "755"
  source node[:etcd][:url]
  action :nothing
  notifies :run, "execute[extract]", :immediately
end

# extracts are into /tmp/etcd. We remove and recreate this every time because
# the tars contain a subdirectory and we've got to make sure our find only
# finds the current version.
execute "extract" do
  user "root"
  group "root"
  cwd '/tmp'
  command %{rm -rf ./etcd && mkdir ./etcd && tar zxf #{tar_file} -C ./etcd}
  action :nothing
  notifies :run, "execute[move]", :immediately
end

execute "move" do
  user "root"
  group "root"
  cwd '/tmp'
  command %{find ./etcd -type f -name etcd -exec mv {} /usr/bin \\;}
  creates node[:etcd][:bin]
  action :nothing
end

http_request "HEAD #{node[:etcd][:url]}" do
  message ""
  url node[:etcd][:url]
  action :head
  if File.exists?(tar_file)
    headers "If-Modified-Since" => File.mtime(tar_file).httpdate
  end
  notifies :create, "remote_file[#{tar_file}]", :immediately
end
