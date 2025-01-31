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

## Result
- VM-1 : Debian - Ansible Control Node/Server
- VM-2 : CentOS - Managed Node #1
- VM-3 : CentOS - Managed Node #2
- VM-4 : CentOS - Managed Node #3

Inventory File - Generated by PowerShell Script and copied to VM-1 under /home/patrol directory.

## Clean Up
- Run 'vagrant destroy' to remove the 3 Managed Node VMs
- Stop & Delete VM-1 in Hyper-V GUI.
