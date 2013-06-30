#
# encoding: utf-8
#
# Cookbook Name:: freistilbox-solo
# Library:: deploy
#
# Copyright (C) 2013 freistil IT
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

require "yaml"

class Chef::Recipe::Freistilbox

  def self.read_boxfile(boxfile_path)

    if File.exists?(boxfile_path)
      boxfile = YAML.load_file(boxfile_path)
    end

    return boxfile

  end


  def self.get_shared_folders(boxfile)
    boxfile_key = 'shared_folders'
    if boxfile.has_key?(boxfile_key)
      return boxfile[boxfile_key]
    else
      return nil
    end
  end

  def self.get_envspecific_files(boxfile, environment)
    file_map = {}
    boxfile_key = 'env_specific_files'
    if boxfile.has_key?(boxfile_key)
      boxfile[boxfile_key].each_pair do |file_path, env_mappings|
        if env_mappings.has_key?(environment)
          file_map[file_path] = env_mappings[environment]
        end # if
      end # each_pair
    end #if
    return file_map
  end

end
