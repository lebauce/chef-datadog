include_recipe '::dd-agent'

# Build a data structure with configuration.
# @see http://docs.datadoghq.com/guides/network_checks/
# @example
#   node.override['datadog']['http_check']['instances'] = [
#     {
#       'name' => 'MyHTTPcheck',
#       'url' => 'http://my.server/some/service',
#       'timeout' => '15',
#       'content_match' => 'string to match',
#       'include_content' => true,
#       'collect_response_time' => true,
#       'tags' => [
#        'myApp',
#        'serviceName'
#       ]
#     }
# ]

datadog_monitor 'http_check' do
  instances node['datadog']['http_check']['instances']
  logs node['datadog']['http_check']['logs']
  action :add
  notifies :restart, 'service[datadog-agent]' if node['datadog']['agent_start']
end
