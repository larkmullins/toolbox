# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

# define source directorys
#applications_dirs = {
#  'styleguide'    => {'src' => '/Users/larkmullins/Development/cadet/styleguide', 'dest' => '/usr/share/nginx/html/styleguide'},
#}

directories = [
  #{:src => '/Users/larkmullins/Development/larkmullins-website',                      :dest => '/home/vagrant/larkmullins-website'},
  #{:src => '/Users/larkmullins/Development/oksanaframework/oksanaframework-website',  :dest => '/home/vagrant/oksanaframework-website'}
]

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.

  # every Vagrant virtual environment requires a box to build off of.
  config.vm.box = "larkmullins/centos7-x86_64-minimal"

  # provider
  config.vm.provider "virtualbox"

  # extend timeout
  config.vm.boot_timeout = 4800

  # check platform (used for provisioning on Windows machines)
  #provisioner = Vagrant::Util::Platform.windows? ? "ansible_local" : "ansible"

  # @TEMPORARY
  # This is only here until Vagrant 1.8.2 gets released which has a fix for
  # Ansible 2.0 new sys calls
  config.vm.provision "shell", inline: "sudo yum install -y python-pip python-dev && sudo pip install ansible==1.9.2"

  # provision
  config.vm.provision "ansible_local" do |ansible|
    ansible.playbook = "playbook.yml"
    ansible.verbose  = true
    ansible.install  = true
  end

  # set static IP address with specified MAC address
  config.vm.network :private_network, ip: "192.168.99.11", :mac => "0800279E51B0"

  # set synced directories and options
  directories.each do |data|
      config.vm.synced_folder data[:src], data[:dest], :mount_options => ['dmode=777', 'fmode=777']
  end
end
