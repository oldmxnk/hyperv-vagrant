# Setup a Lab for Ansible using Vagrant & Hyper-V

## Hyper-V
- Enable Hyper-V on Windows 10/11 Pro Host.
- Create New VM that will be the Ansible Control Server. In this case its Debian 12.x and named "Debian" in Hyper-V.
- Install Ansible in the VM.

## Vagrant
- Install Vagrant on Windows Host.
- Copy 'Vagrantfile' to a Projects dir such as D:\Projects on Windows Host
- Run 'vagrant up' to provision the VMs. This creates 3 VMs running CentOS with 512MB Memory.
- Run 'GenerateInventory.ps1' to generate the inventory file and copy it to the Ansible Host.

 
