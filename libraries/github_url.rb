
class Chef::Recipe
  def gh_bin_url
    version = node[:etcd][:version]

    case version
    when "0.3.0"
      package = "etcd-v#{version}-#{node[:os]}-amd64.tar.gz"
    else
      package = "etcd-v#{version}-#{node[:os].capitalize}-x86_64.tar.gz"
    end

    "https://github.com/coreos/etcd/releases/download/v#{version}/#{package}"
  end
end
