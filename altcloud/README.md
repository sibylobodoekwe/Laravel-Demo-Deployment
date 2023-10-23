# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
    config.vm.box = "ubuntu2204"
   
    config.vm.define "master" do |master|
       master.vm.provider "docker" do |d|
         d.remains_running = true
         docker.ports = ["80:80"]
       end
   
       master.vm.hostname = "master"
       master.vm.network "private_network", ip: "192.168.33.10"
       master.vm.network :forwarded_port, guest: 22, host: 2224
    end
   
    config.vm.define "slave" do |slave|
       slave.vm.provider "docker" do |d|
         d.remains_running = true
         docker.ports = ["80:8080"]
       end
   
       slave.vm.hostname = "slave"
       slave.vm.network "private_network", ip: "192.168.33.14"
       slave.vm.network :forwarded_port, guest: 22, host: 2226
    end
   end