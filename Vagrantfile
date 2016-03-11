# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "centos_box_testing"
  config.vm.box_url = "/Users/bagarwal/vagrant_db/CentOS-6.4-x86_64-v20131103.box"
  config.vm.network "forwarded_port", guest: 80, host: 80
  config.vm.network "private_network", ip: "192.168.33.61"

  config.vm.synced_folder "/export", "/export",owner: 'vagrant', group:'vagrant',:mount_options => ["dmode=777,fmode=777"]
  # config.vm.provider "virtualbox" do |vb|
     # Don't boot with headless mode
     # vb.gui = false
  
     # Use VBoxManage to customize the VM. For example to change memory:
  #   vb.customize ["modifyvm", :id, "--memory", "1024"]
  # end
  #
  config.vm.provision :shell, :path => "puppet/shell/puppet.sh"
  config.vm.provision :shell, :path => "puppet/shell/puppetModules.sh"
  config.vm.provision :shell, :path => "puppet/shell/gitInstall.sh"
  config.vm.provision "puppet" do |puppet|
     puppet.manifests_path = "puppet/manifests"
     puppet.manifest_file  = "site.pp"
     puppet.module_path = "puppet/modules"
  end
end
