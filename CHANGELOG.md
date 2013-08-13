### 1.1.2 
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
