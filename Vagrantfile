# -*- mode:  ruby -*-
# vim: set ft=ruby :
# -*- mode: ruby -*-
# vim: set ft=ruby :

MACHINES = {
:R1 => {
        :box_name => "centos/8",
        #:public => {:ip => '10.10.10.1', :adapter => 1},
        :net => [
                   {ip: '192.168.128.2', adapter: 2, netmask: "255.255.255.248", virtualbox__intnet: "router-net_1"},
                   {ip: '192.168.160.3', adapter:3, netmask: '255.255.255.248', virtualbox__intnet: "router-net_2"}
                ]
  },
  :R2 => {
        :box_name => "centos/8",
        #:public => {:ip => '10.10.10.1', :adapter => 1},
        :net => [
                   {ip: '192.168.160.2', adapter: 2, netmask: "255.255.255.248", virtualbox__intnet: "router-net_2"},
                   {ip: '192.168.192.3', adapter: 3, netmask: "255.255.255.248", virtualbox__intnet: "router-net_3"},
                ]
  },
  :R3 => {
        :box_name => "centos/8",
        :net => [
                   {ip: '192.168.192.2', adapter: 2, netmask: "255.255.255.248", virtualbox__intnet: "router-net_3"},
                   {ip: '192.168.128.3', adapter: 3, netmask: "255.255.255.248", virtualbox__intnet: "router-net_1"},
                ]
  },


}

Vagrant.configure("2") do |config|

  MACHINES.each do |boxname, boxconfig|
    config.vm.synced_folder "./", "/vagrant", type: "rsync", rsync__auto: true, rsync__exclude: ['./hddvm, README.md']
    config.vm.define boxname do |box|

        box.vm.box = boxconfig[:box_name]
        box.vm.host_name = boxname.to_s

        boxconfig[:net].each do |ipconf|
          box.vm.network "private_network", ipconf
        end

        box.vm.provision "shell", inline: <<-SHELL
          mkdir -p ~root/.ssh
          cp ~vagrant/.ssh/auth* ~root/.ssh
          sed -i.bak 's/PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config
          systemctl restart sshd

        SHELL

        box.vm.provision :ansible_local do |ansible|
       #Установка  коллекции community.general, для использования community.general.nmcli (nmcli) управление сетевыми устройствами.
          # ansible.galaxy_command = 'ansible-galaxy collection install community.general'
          ansible.verbose = "vv"
          ansible.install = "true"
          #ansible.limit = "all"
          ansible.tags = boxname.to_s
          # ansible.tags = "facts"
          ansible.inventory_path = "./ansible/inventory/"
          ansible.playbook = "./ansible/playbooks/routers.yml"
          end

      end

  end


end
