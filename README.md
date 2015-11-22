# 使用 rails + mongodb 搭建论坛

该项目是做一个论坛性质的网站，目的是为了学习如何在 Rails 项目中使用 mongodb，并且加深自己的前端技能。使用到的技术包括：

1. Twitter Bootstrap 3
2. Ruby 2.2.2
3. Rails 4.2.3
4. MongoDB 2.6.5
5. coffeescript
6. jQuery

网站的每一个功能点的实现均在[个人博客](http://liuzxc.github.io/articles/)有详细描述：

![Jason's blog]
(http://7xll4p.com1.z0.glb.clouddn.com/mongo_project_01.png)

网站效果：

![liuzxc]
(http://7xll4p.com1.z0.glb.clouddn.com/mongo_project_02.png)

# 构建开发环境

开发环境搭建可以参考我的博客 [使用 Vagrant 构建虚拟开发环境](http://liuzxc.github.io/articles/rails-app-study-16/)，如果你不想使用 vagrant，请参照下面的安装过程：

#### 配置开发环境

##### 安装 git

```sh
sudo apt-get install git-core
```

##### 安装 rbenv 和 ruby-build

```sh
git clone git://github.com/sstephenson/rbenv.git .
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bash_profile
echo 'eval "$(rbenv init -)"' >> ~/.bash_profile
source .bash_profile
git clone https://github.com/sstephenson/ruby-build.git
cd ruby-build/
sudo ./install.sh
```

##### 安装 ruby 和 rails

```sh
sudo apt-get install -y libssl-dev libreadline-dev zlib1g-dev build-essential g++ nodejs

rbenv install 2.2.2
rbenv global 2.2.2

gem sources --remove https://rubygems.org/
gem sources -a https://ruby.taobao.org/
gem install rails -v 4.2.3
```

##### 安装 mongodb

```sh
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10
echo "deb http://repo.mongodb.org/apt/ubuntu trusty/mongodb-org/3.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.0.list
sudo apt-get update
sudo apt-get install -y mongodb-org
```

##### start rails server

```sh
bundle install
rails server
```