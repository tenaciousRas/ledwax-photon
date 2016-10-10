#
# Cookbook Name:: install-nvm
# Recipe:: default
#
# Copyright 2016, Free Beachler, Longevity Software LLC
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
###
# A wrapper for the NVM cookbook

# install nvm
include_recipe 'nvm'

nvm_install node['nvm']['version']  do
  from_source node['nvm']['from_source']
  alias_as_default node['nvm']['alias_as_default']
  action :create
end
