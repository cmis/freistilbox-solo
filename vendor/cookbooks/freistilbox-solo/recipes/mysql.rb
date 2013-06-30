#
# Cookbook Name:: freistilbox-solo
# Recipe:: mysql
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

include_recipe "mysql"
include_recipe "mysql::server"
include_recipe "database::mysql"

mysql_connection_info = {
	:host => "localhost",
	:username => "root",
	:password => node['mysql']['server_root_password']
}

app_name = node['freistilbox']['active_app']

# Create application database
mysql_database app_name do
	connection mysql_connection_info
	action :create
end

# Create application database user and grant full access to application database
mysql_database_user app_name do
	connection mysql_connection_info
	password app_name
	database_name app_name
	action :grant
end
