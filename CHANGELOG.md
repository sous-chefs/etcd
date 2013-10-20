### 1.3.4
* fix compile_time to use the rigth tarball path

### 1.3.3 
* Bump to etcd 1.2
* Added source install recipe

### 1.3.1
* default binding to node[:ipaddress]

### 1.2.4
* update to etcd 0.1.1 release 
* add compile_time recipe that does the whole bit in chef compile time

### 1.2.3
* hotfix to add missing  `node[:etcd][:env_scope]` attribute
* bugfix: use `node[:fqdn]` instead of hostname when matching local machine name

### 1.2.2
* add cluster recipe for setting up clusters of etcd nodes
* re-add seed-node attribute 

### 1.2.1 
* fix the startup args so it is easier to specify custom args
* supports release version and current master on git
* add in tests for both release and git versions of etcd 

### 1.1.1
* Make everything work with release 0.1.0 of etcd
* fixup some syntax issues

### 1.1.0
* move binary install to using coreos/etcd releases from github
* for now the install locattion is fixed to /usr/local and links in /usr/local/bin
* Use ark for managing tarballs
* move bats tests to using etcdctl instead of curl
