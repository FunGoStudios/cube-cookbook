directory "/usr/local/lib/node_modules" do
  owner node["cube"]["npm_deploy_user"]
  group node["cube"]["npm_deploy_user"]
  mode "0755"
  action :create
end

npm_package "cube@0.2.3"
npm_package "cube-dashboard"
npm_package "cube-reports"

template "/etc/init/collector.conf" do
  mode "644"
  notifies :restart, "service[collector]"
end

template "/etc/init/evaluator.conf" do
  mode "644"
  notifies :restart, "service[evaluator]"
end

service "collector" do
  provider Chef::Provider::Service::Upstart
  supports :status => true, :restart => true
  action [ :enable, :start ]
end

service "evaluator" do
  provider Chef::Provider::Service::Upstart
  supports :status => true, :restart => true
  action [ :enable, :start ]
end
