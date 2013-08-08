#Etcd Cookbook

## Supported Platforms
Centos/rhat 6+ & ubuntu with upstart

## Recipes
* *default:* Install and setup the service

* *_service:* Recipe used by default for seting up the service

* *binary_install:* Installs the binary of etcd from a build of etcd from master branch on github

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
