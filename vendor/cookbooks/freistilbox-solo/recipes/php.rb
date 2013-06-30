#
# Cookbook Name:: freistilbox-solo
# Recipe:: php
# Author:: Markus Heurung <markus@freistil.it>
#
# Copyright 2013, freistil IT
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

include_recipe "php"
include_recipe "php::module_apc"
include_recipe "php::module_curl"
include_recipe "php::module_gd"
include_recipe "php::module_memcache"
include_recipe "php::module_mysql"

package "php5-imagick" do
  action :install
  notifies :reload, "service[apache2]"
end

template "/etc/php5/conf.d/imagick.ini" do
  source "php/imagick.ini.erb"
  owner "root"
  group "root"
  mode 0644
  backup false
  notifies :reload, "service[apache2]"
end

package "php5-imap" do
  action :install
  notifies :reload, "service[apache2]"
end

template "/etc/php5/conf.d/imap.ini" do
  source "php/imap.ini.erb"
  owner "root"
  group "root"
  mode 0644
  backup false
  notifies :reload, "service[apache2]"
end

php_pear "uploadprogress" do
  action :install
  channel "pecl.php.net"
  notifies :reload, "service[apache2]"
end

package "php5-xsl" do
  action :install
  notifies :reload, "service[apache2]"
end
