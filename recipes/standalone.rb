#
# Cookbook Name:: jackrabbit
# Recipe:: standalone
# Copyright 2012, Michael S. Klishin <michaelklishin@me.com>
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

include_recipe "java"

#
# User accounts
#

user node.jackrabbit.user do
  comment "Apache Jackrabbit user"
  home    node.jackrabbit.installation_dir
  shell   "/bin/bash"
  action  :create
end

group node.jackrabbit.user do
  (m = []) << node.jackrabbit.user
  members m
  action :create
end


# download the jar
jackrabbit_jar = File.join(node.jackrabbit.installation_dir, "jackrabbit-standalone.jar")

remote_file(jackrabbit_jar) do
  source "http://www.eu.apache.org/dist/jackrabbit/#{node.jackrabbit.version}/jackrabbit-standalone-#{node.jackrabbit.version}.jar"

  action :nothing
  not_if "test -f #{jackrabbit_jar}"
end

directory(node.jackrabbit.installation_dir) do
  owner node.jackrabbit.user
  group node.jackrabbit.user

  action :create
  recursive true
  notifies :create, resources(:remote_file => jackrabbit_jar), :immediately
end


directory(node.jackrabbit.repository_dir) do
  owner node.jackrabbit.user
  group node.jackrabbit.user

  action :create
  recursive true
end


# init.d Service
template "/etc/init.d/jackrabbit" do
  source "jackrabbit.init.erb"
  owner 'root'
  mode  0755
end

service "jackrabbit" do
  supports :start => true, :stop => true, :restart => true
  # start on boot as well as at the end of Chef run
  action [:enable, :start]
end
