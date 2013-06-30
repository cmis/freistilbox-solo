# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "precise32"
  config.vm.box_url = "http://files.vagrantup.com/precise32.box"

  config.vm.hostname = "freistilbox"

  config.vm.network :forwarded_port, host: 3080, guest: 80
  config.vm.network :forwarded_port, host: 3081, guest: 81
  config.vm.network :forwarded_port, host: 3082, guest: 82
  config.vm.network :forwarded_port, host: 3443, guest: 443

  config.cache.auto_detect = true
  #config.cache.enable_nfs  = true

  config.vm.provision :chef_solo do |chef|
    chef.node_name = "freistilbox-solo"
    chef.cookbooks_path = ["cookbooks", "vendor/cookbooks"]
    chef.roles_path = "roles"
    chef.add_role("default")

    chef.json = {
      :freistilbox => {
        :active_app => 'example',
        :app_config => 'drupal'
      },
      :varnish => {
        :vcl_source => "varnish/drupal.vcl.erb"
      }
    }
  end
end
