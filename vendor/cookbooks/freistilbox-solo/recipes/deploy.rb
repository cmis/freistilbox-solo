#
# Cookbook Name:: freistilbox-solo
# Recipe:: deploy
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


app_source = File.join(node['freistilbox']['app_home'], node['freistilbox']['active_app'])
app_root = File.join(node['freistilbox']['web_home'], node['freistilbox']['active_app'])

boxfile_path = File.join(app_source, "Boxfile")
boxfile = Freistilbox.read_boxfile(boxfile_path)

if boxfile

  #
  # Shared folders
  #

  shared_folders = Freistilbox.get_shared_folders(boxfile)

  if shared_folders.nil? || shared_folders.empty?
    rsync_excludes = ''
  else
    rsync_excludes = shared_folders.map{ |folder| "--exclude #{folder}" }.join(" ")
  end

  bash "clone application" do
    cwd app_root
    code <<-EOC
    rsync -a #{rsync_excludes} #{app_source}/ app/
    EOC
  end

  ruby_block "symlink shared folders" do
    block do
      shared_folders.each do |folder|
        link = "#{app_root}/app/docroot/#{folder}"
        unless File.exists?(link)
          File.symlink("#{app_source}/docroot/#{folder}", link)
        end
      end
    end
    not_if shared_folders.nil? || shared_folders.empty?
  end

  #
  # Env-specific files
  #

  envspecific_files = Freistilbox.get_envspecific_files(boxfile, 'solo')
  Chef::Log.info("Mapping: #{envspecific_files.inspect}")

  ruby_block "symlink shared folders" do
    block do
      envspecific_files.each_pair do |canonical_file, specific_file|
        link = File.join(app_root, "/app/docroot", canonical_file)
        target = File.join(app_root, "/app/docroot", File.dirname(canonical_file), specific_file)
        if File.exists?(link)
          Chef::Log.info("Using existing env-specific file #{link}")
        else
          Chef::Log.info("Activating env-specific file #{link}")
          File.symlink(target, link)
        end
      end
    end
    not_if { envspecific_files.nil? || envspecific_files.empty? }
  end

end
