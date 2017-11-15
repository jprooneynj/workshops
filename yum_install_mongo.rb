yum_repository 'mongodb' do
  description "MongoDB Repository"
  baseurl "https://repo.mongodb.org/yum/redhat/$releasever/mongodb-org/3.4/x86_64/"
  gpgkey 'https://www.mongodb.org/static/pgp/server-3.4.asc'
  action :create
end


yum_package 'mongodb-org'