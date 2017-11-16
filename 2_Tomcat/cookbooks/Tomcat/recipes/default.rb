

#
# Cookbook:: Tomcat
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.


yum_package 'java-1.7.0-openjdk-devel'


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
  cwd "/opt/tomcat"
  ignore_failure true
end

execute 'chmod1' do
  command '/bin/chmod g+x conf'
  cwd "/opt/tomcat"
  ignore_failure true
end

execute 'chown' do
  command '/bin/chown -R tomcat webapps/ work/ temp/ logs/'
  cwd "/opt/tomcat" 
  ignore_failure true
end

file '/etc/systemd/system/tomcat.service' do
  content "[Unit]
Description=Apache Tomcat Web Application Container
After=syslog.target network.target

[Service]
Type=forking

Environment=JAVA_HOME=/usr/lib/jvm/jre
Environment=CATALINA_PID=/opt/tomcat/temp/tomcat.pid
Environment=CATALINA_HOME=/opt/tomcat
Environment=CATALINA_BASE=/opt/tomcat
Environment='CATALINA_OPTS=-Xms512M -Xmx1024M -server -XX:+UseParallelGC'
Environment='JAVA_OPTS=-Djava.awt.headless=true -Djava.security.egd=file:/dev/./urandom'

ExecStart=/opt/tomcat/bin/startup.sh
ExecStop=/bin/kill -15 $MAINPID

User=tomcat
Group=tomcat
UMask=0007
RestartSec=10
Restart=always

[Install]
WantedBy=multi-user.target"
end

service 'tomcat' do
  action [:enable, :start]
end
