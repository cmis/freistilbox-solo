# VCL logic file
default['varnish']['vcl_cookbook'] = "freistilbox-solo"
default['varnish']['vcl_source'] = "varnish/#{node['freistilbox']['app_config']}.vcl.erb"

default['varnish']['storage'] = "malloc"
default['varnish']['storage_size'] = "200M"

default['varnish']['listen_address'] = '127.0.0.1'
default['varnish']['listen_port'] = 81

default['varnish']['backend_host'] = 'localhost'
default['varnish']['backend_port'] = 82
