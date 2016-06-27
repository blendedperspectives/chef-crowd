#
# Cookbook Name:: crowd
# Recipe:: configuration
#
# Copyright 2015, KLM Royal Dutch Airlines
#

directory node['crowd']['home_path'] do
  owner node['crowd']['user']
  action :create
  recursive true
end

# Only needed for standalone
if node['crowd']['install_type'] == 'standalone'
  template "#{node['crowd']['install_path']}/crowd/crowd-webapp/WEB-INF/classes/crowd-init.properties" do
    source 'crowd-init.properties.erb'
    mode '0644'
    owner node['crowd']['user']
    group node['crowd']['user']
    notifies :restart, 'service[crowd]', :delayed
  end

  template "#{node['crowd']['install_path']}/crowd/apache-tomcat/bin/setenv.sh" do
    source 'setenv.sh.erb'
    mode '0744'
    owner node['crowd']['user']
    group node['crowd']['user']
    notifies :restart, 'service[crowd]', :delayed
  end
end
