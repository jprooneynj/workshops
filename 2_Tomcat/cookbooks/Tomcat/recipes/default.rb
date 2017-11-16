

#
# Cookbook:: Tomcat
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.


# yum_package 'java-1.7.0-openjdk-devel'


execute 'groupadd' do
  command '/usr/sbin/groupadd tomcat'
  ignore_failure true
end

execute 'useradd' do
  command '/usr/sbin/useradd -M -s /bin/nologin -g tomcat -d /opt/tomcat tomcat'
  ignore_failure true 
end


execute 'get tomcat' do
  command "wget http://apache.cs.utah.edu/tomcat/tomcat-8/v8.0.47/bin/apache-tomcat-8.0.47.tar.gz"
  cwd "/tmp"
end
