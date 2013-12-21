# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant::Config.run do |config|
  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.

  # Allow some extra time for SSH connections; the default of 10s is not always sufficient
  config.ssh.timeout = 30

  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = "centos-6.4-x86_64"

  # The url from where the 'config.vm.box' box will be fetched if it
  # doesn't already exist on the user's system.
  #config.vm.box_url = "centos-6.4-x86_64.box"

  # Boot with a GUI so you can see the screen. (Default is headless)
  #config.vm.boot_mode = :gui

  # Allow the host name to vary via environment variable, defaulting to localhost
  # if no host name is provided.  To override the default hostname, do something
  # like this: <tt>$ VAGRANT_HOSTNAME="mybox" vagrant up</tt>
  config.vm.host_name = ENV['VAGRANT_HOSTNAME'] || "localhost"

  # Assign this VM to a host-only network IP, allowing you to access it
  # via the IP. Host-only networks can talk to the host machine as well as
  # any other machines on the same network, but cannot be accessed (through this
  # network interface) by any external networks.
  # config.vm.network :hostonly, "192.168.33.10"

  # Assign this VM to a bridged network, allowing you to connect directly to a
  # network using the host's network device. This makes the VM appear as another
  # physical device on your network.
  # config.vm.network :bridged
  # config.vm.network :hostonly, "10.10.10.5"

  # Configure Vagrant VM to use host DNS; this can be an issue with Ubuntu hosts
  #config.vm.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]

  # Forward a port from the guest to the host, which allows for outside
  # computers to access the VM, whereas host only networking does not.
  config.vm.forward_port 80, 8080
  config.vm.forward_port 4567, 4568

  # Share an additional folder to the guest VM. The first argument is
  # an identifier, the second is the path on the guest to mount the
  # folder, and the third is the path on the host to the actual folder.
  # config.vm.share_folder "v-data", "/vagrant_data", "../data"

  # Enable provisioning with Puppet stand alone.  Puppet manifests
  # are contained in a directory path relative to this Vagrantfile.
  options = {
    :module_path => "modules", 
    :options => ["--environment", "vagrant"],
  }

  config.vm.provision :puppet, options do |puppet|
    puppet.manifests_path = "manifests"
    puppet.manifest_file  = "site.pp"
  end
end

