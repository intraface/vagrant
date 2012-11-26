Vagrant server for Intraface
== 

Requirements
-- 

- http://vagrantup.com/

Getting vagrant in place
--

Make sure you have added a base box already, see http://vagrantup.com/v1/docs/getting-started/index.html

    vagrant box add base http://files.vagrantup.com/lucid32.box

Setting up Intraface
-- 

You need to symlink the intraface repository into your vagrant folder.

    cd ~/vagrant/projects/intraface
    ln -s intraface-repository intraface.dk

Todo
--

This is still not working. Hopefully soon :)

Documentation
-- 

- https://s3.amazonaws.com/chef-talk/chef-talk.html#intro
- http://iostudio.github.com/LunchAndLearn/2012/03/21/vagrant.html
- http://vimeo.com/9976342
- http://treehouseagency.com/blog/steven-merrill/2011/11/17/vagrant-and-nfs