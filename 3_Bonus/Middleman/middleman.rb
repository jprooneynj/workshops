execute 'apt-get update' do
  command 'apt-get update'
  ignore_failure true
end


execute 'apt-get ruby' do
  command 'apt-get install build-essential libssl-dev libyaml-dev libreadline-dev openssl curl git-core zlib1g-dev bison libxml2-dev libxslt1-dev libcurl4-openssl-dev nodejs libsqlite3-dev sqlite3'
  ignore_failure true
end

execute 'mkdir' do
  command 'mkdir /root/ruby'
  creates '/root/ruby'
  ignore_failure true
end

execute 'wget' do
  command 'wget http://cache.ruby-lang.org/pub/ruby/2.1/ruby-2.1.3.tar.gz'
  action :run
  cwd "/root/ruby"
  ignore_failure true
end

execute 'tar' do
  command "tar -xzf ruby-2.1.3.tar.gz"
  cwd "/root/ruby"
  ignore_failure true
end

execute 'configure' do
  command "./configure"
  cwd "/root/ruby/ruby-2.1.3"
  ignore_failure true
end

execute 'make' do
  command "/usr/bin/make install"
  cwd "/root/ruby/ruby-2.1.3"
  ignore_failure true
end

execute 'apt-get apache2' do
  command 'apt-get install apache2'
end

execute 'a2enmod' do
  command ' a2enmod proxy_http'
  ignore_failure true
end

execute 'a2enmod1' do
  command 'a2enmod rewrite'
  ignore_failure true
end

file 'blog.conf' do
  content "# /etc/apache2/sites-enabled/blog.conf

LoadModule proxy_module modules/mod_proxy.so
LoadModule proxy_http_module modules/mod_proxy_http.so

ProxyRequests Off

<Proxy *>
  Order deny,allow
  Allow from all
</Proxy>


<VirtualHost *:80>
  ServerName <%= node['ipaddress'] %>
  ServerAlias <%= node['ipaddress'] %>

  ProxyRequests Off
  RewriteEngine On
  ProxyPreserveHost On
  ProxyPass / http://localhost:3000/
  ProxyPassReverse / http://localhost:3000/

</VirtualHost>
``"
end

execute 'cp' do
  command 'cp blog.conf /etc/apache2/sites-enabled/blog.conf'
  ignore_failure true
end

execute 'rm apache' do
  command 'rm /etc/apache2/sites-enabled/000-default.conf'
  ignore_failure true
end

service 'apache2' do
  action [:enable, :start]
end

execute 'apt-get git' do
  command ' apt-get install git'
end

execute 'git clone' do
  command 'git clone https://github.com/learnchef/middleman-blog.git'
  cwd "/root/chef-repo"
  ignore_failure true
end

execute 'gen install bundler' do
  command 'gem install bundler'
  cwd '/root/chef-repo/middleman-blog'
  ignore_failure true
end

execute 'chmod' do
  command '/bin/chmod -R 755 /root/chef-repo/middleman-blog/'
  cwd "/root/chef-repo/middleman-blog"
  ignore_failure true
end

execute 'bundle install' do
  command 'bundle install'
  cwd '/root/chef-repo/middleman-blog'
  user 'jprooneynj'
  ignore_failure true
end

execute 'thin install' do
  command 'thin install'
  ignore_failure true
end

execute 'thin update' do
  command '/usr/sbin/update-rc.d -f thin defaults'
  ignore_failure true
end


file '/etc/thin/blog.yml' do
  content "# /etc/thin/blog.yml
pid: tmp/pids/thin.pid
log: log/thin.log
timeout: 30
max_conns: 1024
port: 3000
max_persistent_conns: 512
chdir: <%= @project_install_directory %>
environment: development
servers: 1
address: 0.0.0.0
daemonize: true
``"
end

file '/etc/init.d/thin' do
  content "# /etc/init.d/thin

#!/bin/sh
### BEGIN INIT INFO
# Provides:          thin
# Required-Start:    $local_fs $remote_fs
# Required-Stop:     $local_fs $remote_fs
# Default-Start:     2 3 4 5
# Default-Stop:      S 0 1 6
# Short-Description: thin initscript
# Description:       thin
### END INIT INFO

# Original author: Forrest Robertson

# Do NOT "set -e"

DAEMON=/usr/local/bin/thin
SCRIPT_NAME=/etc/init.d/thin
CONFIG_PATH=/etc/thin
HOME=<%= @home_directory %>

# Exit if the package is not installed
[ -x "$DAEMON" ] || exit 0

case "$1" in
  start)
  HOME=$HOME $DAEMON start --all $CONFIG_PATH
  ;;
  stop)
  HOME=$HOME $DAEMON stop --all $CONFIG_PATH
  ;;
  restart)
  HOME=$HOME $DAEMON restart --all $CONFIG_PATH
  ;;
  *)
  echo "Usage: $SCRIPT_NAME {start|stop|restart}" >&2
  exit 3
  ;;
esac
``"
end

service 'thin' do
  action [:enable, :start]
end
