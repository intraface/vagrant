# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant::Config.run do |config|
  config.vm.box = "base"

  # Boot with a GUI so you can see the screen. (Default is headless)
  # config.vm.boot_mode = :gui

  # Forward a port from the guest to the host, which allows for outside
  # computers to access the VM, whereas host only networking does not.
  config.vm.forward_port 80, 8080

  # Enable provisioning with chef solo, specifying a cookbooks path, roles
  # path, and data_bags path (all relative to this Vagrantfile), and adding 
  # some recipes and/or roles.
  #
  config.vm.provision :chef_solo do |chef|
  #  chef.cookbooks_path = "./cookbooks"
  #  chef.roles_path = "../my-recipes/roles"
  #  chef.data_bags_path = "../my-recipes/data_bags"
    chef.add_recipe "apt"
    chef.add_recipe "openssl"    
    chef.add_recipe "apache2"
    chef.add_recipe "apache2::mod_php5"
    chef.add_recipe "apache2::mod_rewrite"
    chef.add_recipe "mysql"
    chef.add_recipe "mysql::server"
    chef.add_recipe "php"
    chef.add_recipe "php::module_apc"
    chef.add_recipe "php::module_mysql"
    chef.add_recipe "php::module_curl"
    chef.add_recipe "intraface"
  #  chef.add_role "web"
  #  You may also specify custom JSON attributes:
    chef.json = {
      :mysql => {
        :server_root_password => "intraface",
        :server_repl_password => "intraface",
        :server_debian_password => "intraface",
      }
    }
  end
end
