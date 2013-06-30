#
# Cookbook Name:: freistilbox-solo
# Recipe:: varnish
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

include_recipe "varnish"

# Write common admin secret
file "/etc/varnish/secret" do
	content "freistilbox-solo"
	owner "root"
	group "root"
	mode 00600
end
