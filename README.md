#Etcd Cookbook

## Supported Platforms
Centos/rhat 6+ & ubuntu with upstart

## Recipes
* *default:* Install and setup the service

* *_service:* Recipe used by default for seting up the service

* *binary_install:* Installs the binary of etcd from github release tarballs

## Attributes

| attribute | default setting | description | 
|:---------------------------------|:---------------|:-----------------------------------------|
|`default[:etcd][:seed_node]`| nil |If you have multiple nodes set this to the seed node that others should contact when they start to register with the cluster |
|`default[:etcd][:install_method]`| binary | Right now only binary is supported. In the future this will probably go away as there are actual distro packages |
|`default[:etcd][:version]` | 0.1.0 | The release versions to install. binary install will assemble a github url to grab this version |
|`default[:etcd][:sha256]` | 00891.. | The Sha256 hash of the tarball specified by the version or URL attribute| 
|`default[:etcd][:url]` | nil |overide the internal genrated url to specify your own binary tarball |
|`default[:etcd][:port]`| 4001 | The port to start etcd rest interface on |
|`default[:etcd][:raft_port]` | 7001 | Raft cluster communication port |
|`default[:etcd][:state_dir]` | /var/cache/etcd/state | Where etcd will store its state | 



## Usage 
For now just use default. In the future that might change.

````
run_list[etcd]
````

## License and Author

|                      |                                          |
|:---------------------|:-----------------------------------------|
| **Original Author**  | Jesse Nelson <spheromak@gmail.com>       |
| **Copyright**        | Copyright (c) 2013 Jesse Nelson          |

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
