

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

execute 'mkdir' do
  command 'mkdir /opt/tomcat'
  creates '/opt/tomcat'
  action :run  
end

execute 'tar' do
  command "tar xvf apache-tomcat-8*tar.gz.5 -C /opt/tomcat --strip-components=1"
  cwd "/tmp"
end

execute 'chmod' do
  command '/bin/chmod -R g+r conf'
  ignore_failure true
end

execute 'chmod1' do
  command '/bin/chmod g+x conf'
  ignore_failure true
end

execute 'chown' do
  command '/bin/chown -R tomcat webapps/ work/ temp/ logs/'
  ignore_failure true
end
