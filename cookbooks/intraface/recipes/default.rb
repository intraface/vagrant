Chef::Log.debug("Running intraface recipe")

execute "Disable default website" do
  command "sudo a2dissite default"
  notifies :restart, resources(:service => "apache2")
end

web_app "application" do
  template "application.conf.erb"
  notifies :restart, resources(:service => "apache2")
end

execute "Update PEAR packages" do
  command "pear upgrade-all"
  command "sudo pear config-set preferred_state alpha"  
end

channels = [
  "pear.pdepend.org",
  "pear.phpmd.org",
  "pear.docblox-project.org",
  "zend.googlecode.com/svn",
  "pear.swiftmailer.org",
  "pear.doctrine-project.org",
  "pear.saltybeagle.com",
  "pear.symfony-project.com",
  "htmlpurifier.org",
  "pear.michelf.com",
  "pearhub.org"
]

channels.each do |chan|
  php_pear_channel chan do
    action :discover
  end
end

# pear.phpunit.de

phpunit = php_pear_channel "pear.phpunit.de" do
  action :discover
end

php_pear "File_Iterator" do
  channel phpunit.channel_name
  action :install
end

php_pear "Text_Template" do
  channel phpunit.channel_name
  action :install
end

# pear.php.net

php_pear "PEAR_PackageFilemanager" do
  action :install
end

php_pear "PEAR_PackageFilemanager2" do
  action :install
end

php_pear "Translation2" do
  action :install
end

php_pear "Validate" do
  action :install
end

php_pear "XML_RPC2" do
  action :install
end

php_pear "PHP_CodeSniffer" do
  action :install
end

# pear.domain51.com

domain51 = php_pear_channel "pear.domain51.com" do
  action :discover
end

php_pear "Phing_d51PearPkg2Task" do
  channel domain51.channel_name
  action :install
end

# public.intraface.dk

intraface = php_pear_channel "public.intraface.dk" do
  action :discover
end

php_pear "Phing_IlibPearDeployerTask" do
  channel intraface.channel_name
  action :install
end

php_pear "Ilib_Error" do
  channel intraface.channel_name
  action :install
end

php_pear "Ilib_RandomKeyGenerator" do
  channel intraface.channel_name
  action :install
end

php_pear "Ilib_DBQuery" do
  channel intraface.channel_name
  action :install
  preferred_state "alpha"
  options "--force --alldeps"
end

php_pear "IntrafacePublic_Client_XMLRPC" do
  channel intraface.channel_name
  action :install
  preferred_state "alpha"
  options "--force --alldeps"  
end

php_pear "Ilib_Variable" do
  channel intraface.channel_name
  action :install
end

# pear.phing.info

phing = php_pear_channel "pear.phing.info" do
  action :discover
end

php_pear "Phing" do
  channel phing.channel_name
  action :install
end

execute "Write Intraface package file" do
  command "cd /vagrant/intraface.dk"
  command "php generate_package_xml.php make 1.0.0"
end

execute "Create a package of Intraface" do
  command "pear package src/package.xml"
end

execute "Install Intraface and dependencies" do
  command "sudo pear install --alldeps --force Intraface-1.0.0.tgz"
end

execute "Cleaning" do
  command "src/package.xml"
  command "rm Intraface-1.0.0.tgz"
end

execute "Setting up the starting database" do
  command "mysql -e 'create database IF NOT EXISTS intraface_test;'"
  command "php tests/unit/setup_database.php"
end