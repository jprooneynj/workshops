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

