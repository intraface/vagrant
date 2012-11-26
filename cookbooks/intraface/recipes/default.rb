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
end

execute "Install required packages to package Intraface" do
  command "pear config-set preferred_state alpha"
  command "pear channel-discover pear.phpunit.de"
  command "pear channel-discover zend.googlecode.com/svn"
  command "pear channel-discover pear.swiftmailer.org"
  command "pear channel-discover pear.doctrine-project.org"
  command "pear channel-discover pear.saltybeagle.com"
  command "pear channel-discover pear.pdepend.org"
  command "pear channel-discover pear.phpmd.org"
  command "pear channel-discover pear.docblox-project.org"
  command "pear channel-discover pear.domain51.com"
  command "pear channel-discover public.intraface.dk"
  command "pear channel-discover htmlpurifier.org"
  command "pear channel-discover pear.michelf.com"
  command "pear channel-discover pearhub.org"
  command "pear channel-discover pear.phing.info"
  command "pear channel-discover pear.symfony-project.com"
  command "pear install --force --alldeps pear_packagefilemanager"
  command "pear install phing/Phing"
  command "pear install --force domain51/Phing_d51PearPkg2Task"
  command "pear install --force --alldeps intrafacepublic/Phing_IlibPearDeployerTask"
  command "pear install --force --alldeps pear/PHP_CodeSniffer"
  # some of these can be removed when the dependencies in intraface resolves correctly
  command "pear install intrafacepublic/Ilib_Error-1.0.1"
  command "pear install pear/Translation2-2.0.4"
  command "pear install pear/Validate-0.8.5"
  command "pear install pear/XML_RPC2-1.1.1"
  command "pear install intrafacepublic/Ilib_RandomKeyGenerator-0.3.1"
  command "pear install --force intrafacepublic/Ilib_DBQuery-0.1.10"
  command "pear install --force intrafacepublic/IntrafacePublic_Client_XMLRPC"
  command "pear install --force intrafacepublic/Ilib_Variable-1.0.1"
end

execute "Package Intraface and install to pull all dependencies" do
  command "php generate_package_xml.php make 1.0.0"
  command "pear package src/package.xml"
  command "sudo pear install --alldeps --force Intraface-1.0.0.tgz"
  command "sudo rm Intraface-1.0.0.tgz"
end

execute "Setting up the starting database" do
  command "mysql -e 'create database IF NOT EXISTS intraface_test;'"
  command "php tests/unit/setup_database.php"
end
