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
  'nginx' => {
    'name' => 'freistilbox-solo',
    'default_site_enabled' => false
  },
  'varnish' => {
    'vcl_cookbook' => "freistilbox-solo",
    'storage' => "malloc",
    'storage_size' => "200M",
    'listen_address' => '127.0.0.1',
    'listen_port' => 81,
    'backend_host' => 'localhost',
    'backend_port' => 82
  }
})

override_attributes({
  'apache' => {
    'listen_ports' => [ "82", "443" ]
  }
})
