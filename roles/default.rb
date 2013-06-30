name "default"
description "freistilbox Solo default configuration"

run_list(
  "recipe[apt]",
  "recipe[freistilbox-solo]",
  "recipe[freistilbox-solo::deploy]",
  "recipe[freistilbox-solo::apache2]",
  "recipe[freistilbox-solo::php]",
  "recipe[freistilbox-solo::mysql]",
  "recipe[freistilbox-solo::varnish]",
  "recipe[freistilbox-solo::nginx]"
)

default_attributes({
  'freistilbox' => {
    'app_home' => "/vagrant/apps",
    'web_home' => "/var/www/apps"
  },
  'mysql' => {
    'server_root_password' => 'rootpass',
    'server_debian_password' => 'debpass',
    'server_repl_password' => 'rootpass'
  },
  'nginx' => {
    'name' => 'freistilbox-solo',
    'default_site_enabled' => false,
    'large_client_header_buffers_num' => "4",
    'large_client_header_buffers_size' => "8k",
    'client_body_timeout' => "60",
    'client_header_timeout' => "60",
    'send_timeout' => "60"
  },
  'php' => {
    'apc_install' => 'pecl',
    'apc_version' => '3.1.9',
    'apc_shmsize' => '256M',
    'apc_ttl' => '0',
    'memory_limit' => '192M',
    'cli_memory_limit' => '512M',
    'post_max_size' => '100M',
    'upload_max_filesize' => '100M',
    'max_execution_time' => '180',
    'max_input_time' => '180'
  },
  'varnish' => {
    'vcl_cookbook' => "freistilbox-solo",
    'storage' => "malloc",
    'storage_size' => "200M",
    'listen_address' => '127.0.0.1',
    'listen_port' => 81,
    'backend_host' => 'localhost',
    'backend_port' => 82
  },
})

override_attributes({
  'apache' => {
    'listen_ports' => [ "82", "443" ]
  }
})
