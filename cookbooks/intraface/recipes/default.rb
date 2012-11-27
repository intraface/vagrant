Chef::Log.debug("Running intraface recipe")

execute "Disable default website" do
  command "sudo a2dissite default"
  notifies :restart, resources(:service => "apache2")
end

web_app "application" do
  template "application.conf.erb"
  notifies :restart, resources(:service => "apache2")
end

# this only puts the php.ini in the cli version
template "#{node['php']['conf_dir']}/php.ini" do
  source "php.ini.erb"
  owner "root"
  group "root"
  mode "0644"
end

template "/etc/php5/apache2/php.ini" do
  source "php.ini.erb"
  owner "root"
  group "root"
  mode "0644"
end

execute "Update PEAR packages" do
  command "pear upgrade-all"
  command "sudo pear config-set preferred_state alpha"  
end

channels = [
  "pear.pdepend.org",
  "pear.phpmd.org",
  "pear.docblox-project.org",
  "pear.saltybeagle.com",
  "pear.symfony-project.com",
]

channels.each do |chan|
  php_pear_channel chan do
    action :discover
  end
end

# zend.googlecode.com/svn

zend = php_pear_channel "zend.googlecode.com/svn" do
  action :discover
end

php_pear "Zend" do
  channel zend.channel_name
  action :install
end

# htmlpurifier.org

htmlpurifier = php_pear_channel "htmlpurifier.org" do
  action :discover
end

php_pear "HTMLPurifier" do
  channel htmlpurifier.channel_name
  action :install
end

# pear.michelf.com

michelf = php_pear_channel "pear.michelf.com" do
  action :discover
end

php_pear "Markdown" do
  channel michelf.channel_name
  action :install
end

php_pear "SmartyPants" do
  channel michelf.channel_name
  action :install
end

# pear.doctrine-project.org

doctrine = php_pear_channel "pear.doctrine-project.org" do
  action :discover
end

php_pear "Doctrine" do
  channel doctrine.channel_name
  action :install
  version "1.2.4"
end

# pearhub.org

pearhub = php_pear_channel "pearhub.org" do
  action :discover
end

php_pear "bucket" do
  channel pearhub.channel_name
  action :install
end

php_pear "konstrukt" do
  channel pearhub.channel_name
  action :install
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

php_pear "File" do
  action :install
end

php_pear "Config" do
  action :install
end

php_pear "MDB2" do
  preferred_state "beta"  
  version "2.5.0b4"
  action :install
end

php_pear "MDB2_Driver_mysql" do
  preferred_state "beta"
  action :install
end

php_pear "Log" do
  action :install
end

php_pear "Net_IDNA" do
  action :install
end

php_pear "HTTP" do
  action :install
end

php_pear "HTTP_Upload" do
  action :install
end

php_pear "Cache_Lite" do
  action :install
end

php_pear "Image_Tranform" do
  action :install
end

php_pear "Console_Table" do
  action :install
end

php_pear "PEAR_PackageFilemanager" do
  action :install
end

php_pear "PEAR_PackageFilemanager2" do
  action :install
end

php_pear "PHP_CodeSniffer" do
  action :install
end

php_pear "Validate" do
  action :install
end

php_pear "Translation2" do
  action :install
end

php_pear "XML_RPC2" do
  action :install
end

php_pear "Contact_Vcard_Build" do
  action :install
end

php_pear "Date" do
  action :install
end

php_pear "MIME_Type" do
  action :install
end

php_pear "System_Command" do
  action :install
end

php_pear "XML_Util" do
  action :install
end

php_pear "XML_Serializer" do
  action :install
end

php_pear "Text_Wiki" do
  action :install
end

# pear.swiftmailer.org

swift = php_pear_channel "pear.swiftmailer.org" do
  action :discover
end

php_pear "Swift" do
  channel swift.channel_name
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

php_pear "Doctrine_Validator_Nohtml" do
  channel intraface.channel_name
  action :install
end

php_pear "Doctrine_Validator_Greaterthan" do
  channel intraface.channel_name
  action :install
end

php_pear "Doctrine_Template_Positionable" do
  channel intraface.channel_name
  action :install
  preferred_state "alpha"
end

php_pear "Ilib_Position" do
  channel intraface.channel_name
  action :install
end

php_pear "Translation2_Decorator_LogMissingTranslation" do
  channel intraface.channel_name
  action :install
end

php_pear "Services_Eniro" do
  channel intraface.channel_name
  action :install
end

php_pear "Phing_IlibPearDeployerTask" do
  channel intraface.channel_name
  action :install
end

php_pear "ErrorHandler" do
  channel intraface.channel_name
  action :install
  preferred_state "alpha"
end

php_pear "Ilib_ErrorHandler_Handler" do
  channel intraface.channel_name
  action :install
end

php_pear "MDB2_Debug_ExplainQueries" do
  channel intraface.channel_name
  action :install
end

php_pear "phpFlickr" do
  channel intraface.channel_name
  action :install
end

php_pear "IntrafacePublic_CMS_HTML" do
  channel intraface.channel_name
  action :install
end

php_pear "Payment_Quickpay" do
  channel intraface.channel_name
  action :install
end

php_pear "OLE" do
  channel intraface.channel_name
  action :install
end

php_pear "Spreadsheet_Excel_Writer" do
  channel intraface.channel_name
  action :install
end

php_pear "Document_Cpdf" do
  channel intraface.channel_name
  action :install
end

php_pear "Ilib_Error" do
  channel intraface.channel_name
  action :install
  options "--force"  
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

php_pear "Ilib_Filehandler" do
  channel intraface.channel_name
  action :install
  options "--force"  
end

php_pear "Ilib_Keyword" do
  channel intraface.channel_name
  action :install
end

php_pear "Ilib_Filehandler_Controller" do
  channel intraface.channel_name
  action :install
  preferred_state "alpha"
end

php_pear "IntrafacePublic_Debtor_XMLRPC" do
  channel intraface.channel_name
  action :install
end

php_pear "Ilib_Payment_Authorize_Provider_Testing" do
  channel intraface.channel_name
  action :install
  options "--force --alldeps"
end

php_pear "Ilib_Countries" do
  channel intraface.channel_name
  action :install
  options "--force --alldeps"
end

php_pear "IntrafacePublic_CMS" do
  channel intraface.channel_name
  action :install
end

php_pear "IntrafacePublic_CMS_Client_XMLRPC" do
  channel intraface.channel_name
  action :install
  options "--force --alldeps"
end

php_pear "IntrafacePublic_CMS_Controller" do
  channel intraface.channel_name
  action :install
  options "--force --alldeps"
end

php_pear "IntrafacePublic_Admin_Client_XMLRPC" do
  channel intraface.channel_name
  action :install
  options "--force --alldeps"
end

php_pear "IntrafacePublic_OnlinePayment_Client_XMLRPC" do
  channel intraface.channel_name
  action :install
  options "--force --alldeps"
end

php_pear "IntrafacePublic_OnlinePayment_Controller" do
  channel intraface.channel_name
  action :install
  options "--force --alldeps"
end

php_pear "IntrafacePublic_Shop" do
  channel intraface.channel_name
  action :install
  options "--force --alldeps"
end

php_pear "IntrafacePublic_Shop_Client_XMLRPC" do
  channel intraface.channel_name
  action :install
  options "--force --alldeps"
end

php_pear "IntrafacePublic_Shop_Controller" do
  channel intraface.channel_name
  action :install
  options "--force --alldeps"
end

php_pear "IntrafacePublic_Newsletter_Client_XMLRPC" do
  channel intraface.channel_name
  action :install
  options "--force --alldeps"
end

php_pear "IntrafacePublic_Newsletter_Controller" do
  channel intraface.channel_name
  action :install
  options "--force --alldeps"
end

php_pear "ilib_recursive_array_map" do
  channel intraface.channel_name
  action :install
end

php_pear "Ilib_Keyword_Controller" do
  channel intraface.channel_name
  action :install
end

php_pear "Ilib_Date" do
  channel intraface.channel_name
  action :install
end

php_pear "Ilib_Category" do
  channel intraface.channel_name
  action :install
end

php_pear "Ilib_Redirect" do
  channel intraface.channel_name
  action :install
end

php_pear "Ilib_FileImport" do
  channel intraface.channel_name
  action :install
  preferred_state "alpha"
  options "--force --alldeps"
end

php_pear "Ilib_Validator" do
  channel intraface.channel_name
  action :install
  options "--force --alldeps"
end

php_pear "Ilib_ClassLoader" do
  channel intraface.channel_name
  action :install
  options "--force --alldeps"
end

php_pear "DB_Sql" do
  channel intraface.channel_name
  action :install
  options "--force --alldeps"
end

# pear.phing.info

phing = php_pear_channel "pear.phing.info" do
  action :discover
end

php_pear "Phing" do
  channel phing.channel_name
  action :install
  options "--force --alldeps"
end

execute "Setting up the starting database" do
  command "mysql -u root -pintraface -e 'create database IF NOT EXISTS intraface_test;'"
end

execute "Setting up the starting database" do
  command "php /vagrant/intraface.dk/tests/unit/setup_database.php intraface"
end