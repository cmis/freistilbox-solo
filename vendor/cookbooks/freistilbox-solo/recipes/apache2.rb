#
# Cookbook Name:: freistilbox-solo
# Recipe:: apache2
# Author:: Markus Heurung <markus@freistil.it>
# Author:: Jochen Lillich <jochen@freistil.it>
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
# l

include_recipe "apache2"
include_recipe "apache2::mod_expires"
include_recipe "apache2::mod_headers"
include_recipe "apache2::mod_php5"
include_recipe "apache2::mod_rewrite"

#
# Preparations
#

package "cronolog" do
	action :install
end

app_root = File.join(node['freistilbox']['web_home'], node['freistilbox']['active_app'])

#
# Configure Apache
#

template "#{node['apache']['dir']}/sites-available/freistilbox" do
  source "apache2/vhost.conf.erb"
  owner "root"
  group "root"
  mode 00644
  variables(
  	:approot => app_root,
  	:docroot => "#{app_root}/app/docroot"
  )
  notifies :reload, "service[apache2]"
end

apache_site "freistilbox"
