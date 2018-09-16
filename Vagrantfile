# -*- mode: ruby -*-
# vi: set ft=ruby :
Vagrant.configure(2) do |config|
  config.vm.box = "ubuntu/bionic64"
  
  config.vm.synced_folder ".", "/home/vagrant/shared/"

  config.vm.provision "shell", inline: <<-SHELL
    sudo apt-get update
    sudo apt-get install -y libwebkit2gtk-4.0-dev libgtk+-3-dev
    sudo apt-get install -y gcc-aarch64-linux-gnu g++-aarch64-linux-gnu
  SHELL
end
