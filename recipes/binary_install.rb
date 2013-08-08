#
# Installs etcd from binary
#

remote_file node[:etcd][:bin] do
  mode "755"
  source node[:etcd][:url]
  action :nothing
end

http_request "HEAD #{node[:etcd][:url]}" do
  message ""
  url node[:etcd][:url]
  action :head
  if File.exists?(node[:etcd][:bin])
    headers "If-Modified-Since" => File.mtime(node[:etcd][:bin]).httpdate
  end
  notifies :create, "remote_file[#{node[:etcd][:bin]}]", :immediately
end
