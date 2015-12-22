#!/usr/bin/env bash
sudo update-locale LC_ALL="en_US.utf8"

echo "Install mongodb:"
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10
echo 'deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen' | sudo tee /etc/apt/sources.list.d/mongodb.list

echo "Add Ruby sources:"
sudo apt-add-repository -y ppa:brightbox/ruby-ng

sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get install -y git ruby2.2 ruby2.2-dev mongodb-10gen nodejs zlib1g-dev build-essential g++ libsqlite3-dev

gem sources --add https://ruby.taobao.org/ --remove https://rubygems.org/

sudo gem install bundler
bundle config mirror.https://rubygems.org https://ruby.taobao.org
