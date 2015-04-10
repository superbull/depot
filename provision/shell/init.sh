#!/bin/bash
#

# yum install epel-release -y
# yum update -y
# yum groupinstall -y "Development Tools"


# update SQLite
# wget http://www.sqlite.org/2015/sqlite-autoconf-3080803.tar.gz
# tar zxvf sqlite-autoconf-3080803.tar.gz
# cd sqlite-autoconf-3080803
# ./configure
# make
# make install


# install rvm with ruby
if ! ruby --version; then
  # sudo gpg2 --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
  command curl -sSL https://rvm.io/mpapis.asc | gpg2 --import -
  \curl -sSL https://get.rvm.io | bash -s stable --ruby
fi


# install node.js
if ! node --version; then
  curl -sL https://rpm.nodesource.com/setup | bash -
  yum install -y nodejs
fi


# install gems
#
cd /vagrant

# using new sqlite3 lib to build sqlites gem
bundle config build.sqlite3 --with-sqlite3-lib=/usr/local/lib --with-sqlite3-include=/usr/local/include
bundle install
bundle exec rake db:migrate
bundle exec rake db:seed

# install chef
# gem install chef --no-rdoc --no-ri --conservative