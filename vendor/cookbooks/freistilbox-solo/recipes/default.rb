#
# Cookbook Name:: freistilbox-solo
# Recipe:: default
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
# limitations under the License.
#

#
# Preparations
#

# Create vhost main directory
directory node['freistilbox']['web_home'] do
  action :create
  owner "www-data"
  group "www-data"
  mode 00755
  recursive true
end

# Create application subdirectories
app_root = File.join(node['freistilbox']['web_home'], node['freistilbox']['active_app'])

directory app_root do
  action :create
  owner "www-data"
  group "www-data"
  mode 00755
  recursive true
end

%w( app logs tmp ).each do |subdir|
  directory "#{app_root}/#{subdir}" do
    action :create
    owner "www-data"
    group "www-data"
    mode 00755
  end
end
