
# Tomcat


Description

This cookbook is used to install and configure tomcat on a particular node server. 

This cookbook will check on the release of Java and install java-1.7.0-openjdk-devel 
using yum should it not already be installed.  

Installs Tomcat from tarballs on the Apache.org website. 
Tomcat will be configued and started up after it is installed.

It is assumed that root is the installation user because of the installation of Java 
and also to ensure the proper permission settings. 
 

Changes

v 1.0.0 - JPR - Initial release



Requirements

Server must have internet access

Platforms

RHEL

Output from hostnamectl on tested platform:

   Static hostname: RHEL
         Icon name: computer-vm
           Chassis: vm
        Machine ID: e198b57826ab4704a6526baea5fa1d06
           Boot ID: fa1d3663217d43dda473ecca991eb7c7
    Virtualization: microsoft
  Operating System: Red Hat Enterprise Linux Server 7.4 (Maipo)
       CPE OS Name: cpe:/o:redhat:enterprise_linux:7.4:GA:server
            Kernel: Linux 3.10.0-693.5.2.el7.x86_64
      Architecture: x86-64

Execution user: root

Software dependencies: java-1.7.0-openjdk-devel

Chef 13.2+


Cookbooks

none


Attributes

None


Recipes

default



Resources/Providers



Usage



Examples

Tested from the Tomcat/cookbooks/recipes directory

chef-client --local-mode default.rb

License and Author

Author:: John Rooney

Copyright:: 2017, Opscode, Inc

Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0
Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.

