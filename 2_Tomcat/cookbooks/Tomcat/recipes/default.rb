
#
# Cookbook:: Tomcat
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.


# yum_package 'java-1.7.0-openjdk-devel'


execute 'groupadd' do
  command '/usr/sbin/groupadd tomcat'
end

execute 'useradd' do
  command '/usr/sbin/useradd -M -s /bin/nologin -g tomcat -d /opt/tomcat tomcat'
end
