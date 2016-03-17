# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

# define source directorys
#applications_dirs = {
#  'styleguide'    => {'src' => '/Users/larkmullins/Development/cadet/styleguide', 'dest' => '/usr/share/nginx/html/styleguide'},
#}

utils_dirs = [
  {:name => 'oksanadb',        :src => '/Users/larkmullins/Development/oksanadb',        :dest => '/home/vagrant/oksanadb'},
  {:name => 'larkmullins.com', :src => '/Users/larkmullins/Development/larkmullins.com', :dest => '/home/vagrant/larkmullins.com'}
]

web_dirs = [
  {:name => 'larkmullins.com', :src => '/Users/larkmullins/Development/larkmullins.com', :dest => '/usr/share/nginx/html/larkmullins'}
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
  provisioner = Vagrant::Util::Platform.windows? ? "ansible_local" : "ansible"

  # docker test
  #config.vm.define "containers" do |containers|
  #  containers.vm.provision :docker
  #  containers.vm.provision :docker_compose, yml: "/vagrant/provisioners/containers/compose.yml", rebuild: true, run: "always"

  #  # set static IP address with specified MAC address
  #  containers.vm.network :private_network, ip: "192.168.91.32", :mac => "0800279E51B0"
  #end

  # utils
  config.vm.define "utils" do |utils|
      # provision nginx
      utils.vm.provision "ansible", type: provisioner do |ansible|
          ansible.playbook = "provisioners/utils/playbook.yml"

          # install ansible on guest
          if provisioner == "ansible_local"
            ansible.install = true
          end
      end

      # setup port forwarding
      utils.vm.network :forwarded_port, guest: 80, host: 8080, auto_correct: true

      # set static IP address with specified MAC address
      utils.vm.network :private_network, ip: "192.168.99.11", :mac => "0800279E51B0"

      # set synced directories and options
      utils_dirs.each do |data|
          utils.vm.synced_folder data[:src], data[:dest], :mount_options => ['dmode=777', 'fmode=777']
      end
  end

  # web server (nginx)
  config.vm.define "web" do |web|
      # provision nginx
      web.vm.provision "nginx", type: provisioner do |ansible|
          ansible.playbook = "provisioners/web/playbook.yml"

          # install ansible on guest
          if provisioner == "ansible_local"
            ansible.install = true
          end
      end

      # setup port forwarding
      web.vm.network :forwarded_port, guest: 80, host: 8080, auto_correct: true

      # set static IP address with specified MAC address
      web.vm.network :private_network, ip: "192.168.99.22", :mac => "0800279E51B0"

      # set synced directories and options
      web_dirs.each do |data|
          web.vm.synced_folder data[:src], data[:dest], :mount_options => ['dmode=777', 'fmode=777']
      end
  end
end
